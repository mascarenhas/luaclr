local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

visitor = {}

function visitor.block(compiler, block)
  for _, stat in ipairs(block) do
    compiler:compile(stat, 0)
  end
end

function visitor.chunk(compiler, chunk)
  compiler:start_function(chunk)
  compiler:compile(chunk.block)
  compiler.ilgen:emit(OpCodes.ldnull)
  compiler.ilgen:emit(OpCodes.ret)
  compiler:end_function()
end

visitor["while"] = function (compiler, nwhile)
  local test = compiler.ilgen:define_label()
  local out = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(test)
  compiler:compile(nwhile.exp)
  compiler.ilgen:jump_if_false(out)
  compiler:compile(nwhile.block)
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:end_loop()
end

visitor["repeat"] = function (compiler, nrepeat)
  local top = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(top)
  compiler:compile(nrepeat.block)
  compiler:compile(nrepeat.exp)
  compiler.ilgen:jump_if_false(top)
  compiler.ilgen:end_loop()
end

visitor["if"] = function (compiler, nif)
  local out = compiler.ilgen:define_label()
  local lelse = compiler.ilgen:define_label()
  compiler:compile(nif.cond)
  compiler.ilgen:jump_if_false(lelse)
  compiler:compile(nif.block)
  compiler.ilgen:emit(OpCodes.br, out)
  compiler.ilgen:mark_label(lelse)
  if nif.block_else then
    compiler:compile(nif.block_else)
  end
  compiler.ilgen:mark_label(out)
end

visitor["do"] = function (compiler, ndo)
  compiler:compile(ndo.block)
end

function visitor.nfor(compiler, nfor)
  local test = compiler.ilgen:define_label()
  local loop = compiler.ilgen:define_label()
  compiler:compile(nfor.start)
  compiler.ilgen:store_local(nfor.var.ref)
  local temp_finish = compiler.ilgen:get_temp()
  compiler:compile(nfor.finish)
  compiler.ilgen:store_local(temp_finish)
  local temp_step = compiler.ilgen:get_temp()
  if nfor.step then
    compiler:compile(nfor.step)
    compiler.ilgen:store_local(temp_step)
  end
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(loop)
  compiler.ilgen:start_loop()
  compiler:compile(nfor.block)
  if nfor.step then
    compiler.ilgen:add(nfor.var, { tag = "name", ref = temp_step })
    compiler.ilgen:store_local(nfor.var.ref)
  else
    compiler.ilgen:add(nfor.var, { tag = "number", val = 1})
    compiler.ilgen:store_local(nfor.var.ref)
  end
  compiler.ilgen:mark_label(test)
  compiler.ilgen:rel("ble", nfor.var, { tag = "name", ref = temp_finish }, loop)
  compiler.ilgen:end_loop()
  compiler.ilgen:release_temp(temp_finish)
  compiler.ilgen:release_temp(temp_step)
end

function visitor.gfor(compiler, gfor)
  local temp_control = gfor.vars[1].ref
  local temp_state = compiler.ilgen:get_temp()
  local temp_iter = compiler.ilgen:get_temp()
  compiler.ilgen:explist(gfor.exps, 3)
  compiler.ilgen:store_local(temp_control)
  compiler.ilgen:store_local(temp_state)
  compiler.ilgen:store_local(temp_iter)
  local test = compile.ilgen:define_label()
  compile.ilgen:mark_label(test)
  compiler.ilgen:load_local(temp_iter)
  compiler.ilgen:emit(OpCodes.ldfld, compiler.ilgen.luavalue_ref)
  compiler.ilgen:load_local(temp_state)
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:call(2, #gfor.vars)
  for i = #gfor.vars, 1, -1 do
    compiler.ilgen:store_local(gfor.vars[i].ref)
  end
  local out = compiler.ilgen:define_label()
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:jump_if_nil(out)
  compiler:compile(gfor.block)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:end_loop()
  compiler.ilgen:release_temp(temp_iter)
  compiler.ilgen:release_temp(temp_state)
end

visitor["function"] = function (compiler, nfunction)
  compiler:start_function(nfunction)
  compiler:compile(nfunction.block)
  compiler.ilgen:emit(OpCodes.ldnull)
  compiler.ilgen:emit(OpCodes.ret)
  local func = compiler:end_function()
  compiler.ilgen:new_func(func)
end

visitor["local"] = function (compiler, nlocal)
  if nlocal.exps then
    compiler.ilgen:explist(nlocal.exps, #nlocal.names)
    for i = #nlocal.names, 1, -1 do
      compiler.ilgen:store_local(nlocal.names[i].ref)
    end
  end
end

function visitor.assign(compiler, assign)
  compiler.ilgen:explist(assign.exps, #assign.vars)
  for i = #assign.vars, 1, -1 do
    compiler:compile(assign.vars[i])
  end
end

visitor["break"] = function (compiler, nbreak)
  compiler.ilgen:break_loop()
end

visitor["return"] = function (compiler, nreturn)
  compiler.ilgen:argslist(nreturn.exps, true)
  compiler.ilgen:emit(OpCodes.ret)
end

function visitor.var(compiler, var)
  if var.ref.tag == "name" then
    if var.ref.ref then
      compiler.ilgen:store_local(var.ref.ref)
    else
      compiler.ilgen:store_global(var.ref.val)
    end
  elseif var.ref.tag == "index" then
    local val = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(val)
    compiler:compile(var.ref.table)
    compiler.ilgen:emit(OpCodes.ldfld, compiler.ilgen.luavalue_ref)
    compiler:compile(var.ref.index)
    compiler.ilgen:load_local(val)
    compiler.ilgen:settable()
    compiler.ilgen:release_temp(val)
  else
    error("invalid lvalue in code generation")
  end
end

function visitor.index(compiler, pexp)
  compiler:compile(pexp.table)
  compiler.ilgen:emit(OpCodes.ldfld, compiler.ilgen.luavalue_ref)
  compiler:compile(pexp.index)
  compiler.ilgen:gettable()
end

function visitor.string(compiler, s)
  compiler.ilgen:load_string(s.val)
end

function visitor.number(compiler, n)
  compiler.ilgen:load_number(n.val)
end

function visitor.constructor(compiler, cons)
  compiler.ilgen:new_table()
end

function visitor.namefield(compiler, namefield)
-- TODO
  tie_refs(st, namefield.exp)
end

function visitor.indexfield(compiler, indexfield)
-- TODO
  tie_refs(st, indexfield.name)
  tie_refs(st, indexfield.exp)
end

function visitor.name(compiler, name)
  if name.ref then
    compiler.ilgen:load_local(name.ref)
  else
    compiler.ilgen:load_global(name.val)
  end
end

function visitor.binop(compiler, binop)
  local arith_ops = { ["+"] = "add", ["-"] = "sub", ["/"] = "div",
    ["*"] = "mul", ["%"] = "mod", ["^"] = "exp" }
  local rel_ops = { ["=="] = "beq", ["~="] = "bne", ["<"] = "blt",
    [">"] = "bgt", ["<="] = "ble", [">="] = "bge" }
  if arith_ops[binop.op] then
    compiler.ilgen:arith(arith_ops[binop.op], binop.left, binop.right)
  elseif rel_ops[binop.op] then
    compiler.ilgen:rel(rel_ops[binop.op], binop.left, binop.right)
  elseif binop.op == "and" or binop.op == "or" then
    compiler.ilgen["logical_" .. binop.op](compiler.ilgen, 
					   binop.left, binop.right)
  else
    error("invalid binary operator")
  end
end

function visitor.unop(compiler, unop)
  if unop.op == "-" then
    compiler.ilgen:neg(unop.operand)
  elseif unop.op == "#" then
    compiler.ilgen:len(unop.operand)
  elseif unop.op == "not" then
    compiler.ilgen:logical_not(unop.operand)
  else
    error("invalid unary operator")
  end
end

function visitor.call(compiler, call, nres)
  local self_arg = compiler.ilgen:get_temp(compiler.ilgen.luaref_type)
  compiler:compile(call.func)
  compiler.ilgen:emit(OpCodes.ldfld, compiler.ilgen.luavalue_ref)
  if call.method then
    compiler.ilgen:emit(OpCodes.dup)
    compiler.ilgen:store_local(self_arg)
    compiler.ilgen:load_string(call.method)
    compiler.ilgen:gettable()
    table.insert(call.args, 1, { tag = "name", ref = self_arg })
  end
  local nargs = compiler.ilgen:argslist(call.args)
  compiler.ilgen:call(nargs, nres)
  if call.method then
    table.remove(call.args, 1)
  end
  compiler.ilgen:release_temp(self_arg)
end

function compile(compiler, node, ...)
  if node and node.tag then 
    visitor[node.tag](compiler, node, ...)
  else
    if type(node) == "table" then
      visitor.block(compiler, node)
    elseif type(node) == "nil" or node == "nil" then
      compiler.ilgen:load_nil()
    elseif node == "true" then
      compiler.ilgen:load_true()
    elseif node == "false" then
      compiler.ilgen:load_false()
    else
      error("node " .. node .. "not supported by compiler yet")
    end
  end
end

