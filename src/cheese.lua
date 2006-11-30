-- Cheese: a PEG parser generator for Lua, in Lua

module("cheese", package.seeall)

function parse_error(data)
  return error(data)
end

function flatten (tab)
  if type(tab) == "table" then
    local res = {}
    for i, l in ipairs(tab) do
      res[i] = flatten(l)
    end
    return table.concat(res)
  else
    return tostring(tab)
  end
end

local function memoize(func)
  local cache = {}
  return function (strm)
	   local state = strm:state()
	   local strm_cache = cache[strm]
	   local res
	   if not strm_cache then
	     strm_cache = {}
	     cache[strm] = strm_cache
	     res = { func(strm), strm:state() }
	     strm_cache[state] = res
	   else
	     res = strm_cache[state] 
	     if not res then
	       res = { func(strm), strm:state() }
	       strm_cache[state] = res
	     else strm:backtrack(res[2]) end
	   end
	   return res[1]
         end
end

function lazy(thunk, ...)
  local exp
  local args = {...}
  return function (strm, clear)
	   exp = (not clear and exp) or thunk(unpack(args))
	   return exp(strm)
	 end
end

function char(c)
  return function (strm)
		   local cc = strm:getc()
		   if cc == c then
		     return cc
		   else
		     return parse_error({tag = "char", stream = strm, class = args})
		   end
		 	         end
end

function str(s)
  return function (strm)
		   local ss = strm:gets(string.len(s))
		   if (not ss) or (s ~= ss) then
		     return parse_error({tag = "string", stream = strm, string = s})
		   end
		   return ss
		 	         end
end

function class(...)
  local args = {...}
  return function (strm)
		   local c = strm:getc()
		   if not c then
		     return parse_error({tag = "class", stream = strm, class = args})
		   end
		   for i = 1, #args, 2 do
		     if (c >= args[i]) and (c <= args[i+1]) then
		       return c
		     end
		   end
		   return parse_error({tag = "class", stream = strm, class = args})
		 end
end

any = function (strm)
	return strm:getc()
      end

digit = class("0", "9")

function opt(exp)
  if not exp then error("nil expression") end
  return (function (strm)
		   local state = strm:state()
		   local ok, res = pcall(exp, strm)
		   if ok then
		     return res
		   else
		     strm:backtrack(state)
		     return {}
		   end
	         end)
end

function star(exp)
  if not exp then error("nil expression") end
  return (function (strm)
		   local state = strm:state()
		   local list = {}
		   local ok, res = pcall(exp, strm)
		   while ok do
		     table.insert(list, res)
		     state = strm:state()
		     ok, res = pcall(exp, strm)
		   end
		   strm:backtrack(state)
		   return list
		 end)
end

function plus(exp)
  if not exp then error("nil expression") end
  return function (strm)
		   local state, ok
		   local list = {}
		   local res = exp(strm)
		   repeat
		     table.insert(list, res)
		     state = strm:state()
		     ok, res = pcall(exp, strm)
		   until not ok
		   strm:backtrack(state)
		   return list
		 end
end

function pand(exp)
  if not exp then error("nil expression") end
  return (function (strm)
		   local state = strm:state()
		   local ok, res = pcall(exp, strm)
		   strm:backtrack(state)
		   if ok then
		     return {}
		   else
		     return parse_error(res)
		   end
	         end)
end

function pnot(exp)
  if not exp then error("nil expression") end
  return (function (strm)
		   local state = strm:state()
		   local ok, res = pcall(exp, strm)
		   strm:backtrack(state)
		   if ok then
		     return parse_error({tag = "not", stream = strm })
		   else
		     return {}
		   end
	         end)
end

function seq(...)
  if select("#", ...) < 2 then error("sequence with too few elements") end
  for i = 1, select("#", ...) do
    if not select(i, ...) then error("nil expression") end
  end
  local args = {...}
  return (function (strm)
		   --local state = strm:state()
		   local list = {}
		   for i, exp in ipairs(args) do
		     local ok, res = pcall(exp, strm)
		     if ok then
		       table.insert(list, res)
		     else
		       --strm:backtrack(state)
		       return parse_error(res)
		     end
		   end
		   return list
	         end)
end

function choice(...)
  if select("#", ...) < 2 then error("sequence with too few elements") end
  for i = 1, select("#", ...) do
    if not select(i, ...) then error("nil expression") end
  end
  local args = {...}
  return (function (strm)
		   for i, exp in ipairs(args) do
		     local state = strm:state()
		     local ok, res = pcall(exp, strm)
		     if ok then
		       return res
		     end
		     strm:backtrack(state)
		   end
	           return parse_error({tag = "choice", stream = strm})
		 end)
end

function concat(exp)
  if not exp then error("nil expression") end
  return function (strm)
	   local res = exp(strm)
	   return flatten(res)
	 end
end

function skip(exp)
  if not exp then error("nil expression") end
  return function (strm)
	   exp(strm)
	   return {}
	 end
end

function bind(exp, func)
  if not exp then error("nil expression") end
  return function (strm)
	   return func(exp(strm))
	 end
end

function handle(exp, func)
  if not exp then error("nil expression") end
  return function (strm)
	   local ok, res = pcall(exp, strm)
   	   if ok then return res else return func(res) end
	 end
end

function compile_dec(env, dec)
end

function compile(decs)
  local parsers = {}
  setmetatable(parsers, { __index = function (tab, name)
				      return cheese.lazy(function () return tab[name] end)
				    end })

end