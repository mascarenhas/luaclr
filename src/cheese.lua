-- Parser generator

local cheese_parsers = require"cheese.parsers"

module("cheese", package.seeall)

parse_error = cheese_parsers.parse_error

local rule_mt

local function make_rule(tab)
  setmetatable(tab, rule_mt)
  return tab
end

function concat (tab)
  if type(tab) == "table" then
    local res = {}
    for i, l in ipairs(tab) do
      res[i] = concat(l)
    end
    return table.concat(res)
  else
    return tostring(tab)
  end
end

function skip(exp)
  return {}
end

function char(c)
  return make_rule{ tag = "char", char = c }
end

function class(...)
  return make_rule{ tag = "class", ranges = {...} }
end

function str(s)
  return make_rule{ tag = "string", str = s }
end

function opt(rule)
  if rule.tag == "opt" then return rule end
  return make_rule{ tag = "opt", rule = rule }
end

function pand(rule)
  if rule.tag == "and" then return rule end
  return make_rule{ tag = "and", rule = rule }
end

function pnot(rule)
  if rule.tag == "not" then
    return make_rule{ tag = "and", rule = rule.rule }
  end
  return make_rule{ tag = "not", rule = rule }
end

local function include_rule(tag, rules, rule)
  if rule.tag == tag then
    for _, r in ipairs(rule.rules) do
      table.insert(rules, r)
    end
  else
    table.insert(rules, rule)
  end
end

function seq(...)
  local rules = {}
  for i = 1, select("#", ...) do
    include_rule("seq", rules, select(i, ...))
  end
  return make_rule{ tag = "seq", rules = rules }
end

function choice(...)
  local rules = {}
  for i = 1, select("#", ...) do
    include_rule("choice", rules, select(i, ...))
  end
  return make_rule{ tag = "choice", rules = rules }
end

function star(rule)
  if rule.tag == "star" then return rule end
  return make_rule{ tag = "star", rule = rule }
end

function plus(rule)
  if rule.tag == "plus" then return rule end
  return make_rule{ tag = "plus", rule = rule }
end

function ref(name)
  return make_rule{ tag = "ref", name = name }
end

function ext(parser)
  return make_rule{ tag = "ext", parser = parser }
end

function bind(rule, ...)
  if rule.tag == "bind" then
    local funcs = {}
    for _, f in ipairs(rule.funcs) do
      table.insert(funcs, f)
    end
    for i = 1, select("#", ...) do
      table.insert(funcs, select(i, ...))
    end
    return make_rule{ tag = "bind", rule = rule.rule, funcs = funcs }
  else
    return make_rule{ tag = "bind", rule = rule, funcs = {...} }
  end
end

function handle(rule, func)
  return { tag = "handle", rule = rule, func = func }
end

rule_mt = {
  __concat = seq,
  __div = choice,
  __mod = bind,
  __exp = handle
}

any = make_rule{ tag = "any" }

digit = make_rule{ tag = "class", ranges = { { "0", "9" } } }

function compile_rule(rule, rules, parsers)
  return _M["compile_" .. rule.tag](rule, rules, parsers)
end

function compile_ref(rule, rules, parsers)
  return compile_named(rule.name, rules, parsers)
end

function compile_any()
  return cheese_parsers.any
end

function compile_char(rule)
  return cheese_parsers.char(rule.char)
end

function compile_class(rule)
  return cheese_parsers.class(unpack(rule.ranges))
end

function compile_string(rule)
  return cheese_parsers.str(rule.str)
end

function compile_opt(rule, rules, parsers)
  return cheese_parsers.opt(compile_rule(rule.rule, rules, parsers))
end

function compile_star(rule, rules, parsers)
  return cheese_parsers.star(compile_rule(rule.rule, rules, parsers))
end

function compile_plus(rule, rules, parsers)
  return cheese_parsers.plus(compile_rule(rule.rule, rules, parsers))
end

function compile_and(rule, rules, parsers)
  return cheese_parsers.pand(compile_rule(rule.rule, rules, parsers))
end

function compile_not(rule, rules, parsers)
  return cheese_parsers.pnot(compile_rule(rule.rule, rules, parsers))
end

function compile_seq(rule, rules, parsers)
  local ps = {}
  for _, r in ipairs(rule.rules) do
    table.insert(ps, compile_rule(r, rules, parsers))
  end
  return cheese_parsers.seq(unpack(ps))
end

function compile_choice(rule, rules, parsers)
  local ps = {}
  for _, r in ipairs(rule.rules) do
    table.insert(ps, compile_rule(r, rules, parsers))
  end
  return cheese_parsers.choice(unpack(ps))
end

function compile_ext(rule, rules, parsers)
  return rule.parser
end

function compile_bind(rule, rules, parsers)
  return cheese_parsers.bind(compile_rule(rule.rule, rules, parsers), rule.funcs)
end

function compile_handle(rule, rules, parsers)
  return cheese_parsers.handle(compile_rule(rule.rule, rules, parsers), rule.func)
end

function compile_named(name, rules, parsers)
  -- Found a recursive definition, returns a thunk
  if parsers[name] == true then
    parsers[name] = cheese_parsers.lazy(function () return parsers[name] end)
  elseif not parsers[name] then
    -- Marker to avoid infinite recursion
    parsers[name] = true
    parsers[name] = compile_rule(rules[name], rules, parsers)
  end
    return parsers[name]
end

function compile(rules)
  if getmetatable(rules) == rule_mt then
    return compile_rule(rules, {}, {})
  else
    local parsers = {}
    for name, rule in pairs(rules) do
      compile_named(name, rules, parsers)
    end
    return parsers
  end
end

function open_grammar(grammar_table)
  local env = getfenv(2)
  local old_mt = getmetatable(env)
  if type(grammar_table) == "string" then
    env[grammar_table] = env[grammar_table] or {}
    grammar_table = env[grammar_table]
  end
  local grammar_env = {
    char = char, class = class, digit = digit, any = any,
    plus = plus, star = star, opt = opt, pand = pand, pnot = pnot,
    seq = seq, choice = choice, bind = bind, handle = handle,
    concat = concat, skip = skip, ext = ext, close = close_grammar,
    str = str, ref = ref
  }
  local mt_grammar = { grammar = grammar_table, old_mt = old_mt }
  function mt_grammar.__index(t, k)
    if grammar_env[k] then
      return grammar_env[k]
    elseif old_mt and type(old_mt.__index) == "table" and old_mt.__index[k] then
      return old_mt.__index[k]
    elseif old_mt and type(old_mt.__index) == "function" and old_mt.__index(t, k) then
      return old_mt.__index(t, k)
    elseif type(k) == "string" then
      return ref(k)
    else
      return nil
    end
  end
  function mt_grammar.__newindex(t, k, v)
    if getmetatable(v) == rule_mt then
      mt_grammar.grammar[k] = v
    elseif old_mt and type(old_mt.__newindex) == "table" then
      old_mt.__newindex[k] = v
    elseif old_mt and type(old_mt.__newindex) == "function" then
      old_mt.__newindex(t, k, v)
    else
      rawset(t, k, v)
    end
  end
  setmetatable(env, mt_grammar)
end

function close_grammar()
  local env = getfenv(2)
  local mt_grammar = getmetatable(env)
  setmetatable(env, mt_grammar.old_mt)
end
