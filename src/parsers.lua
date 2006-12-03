-- Parser combinators

module("cheese.parsers", package.seeall)

function parse_error(message, strm)
  local err_data = { msg = message, state = strm:state() }
  return error(err_data)
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
		     return parse_error("character match", strm)
		   end
		 end
end

function str(s)
  return function (strm)
		   local ss = strm:gets(string.len(s))
		   if (not ss) or (s ~= ss) then
		     return parse_error("string match", strm)
		   end
		   return ss
		 	         end
end

function class(...)
  local args = {...}
  return function (strm)
		   local c = strm:getc()
		   if not c then
		     return parse_error("character match", strm)
		   end
		   for _, class in ipairs(args) do
		     local type_class = type(class)
		     if (type_class == "string" and
			 c == class) or
		        (type_class == "table" and
		         c >= class[1] and c <= class[2]) then
		       return c
		     end
		   end
		   return parse_error("character match", strm)
		 end
end

any = function (strm)
	return strm:getc()
      end

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
		     return error(res)
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
		     return parse_error("predicate not", strm)
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
		   local list = {}
		   for i, exp in ipairs(args) do
		     local ok, res = pcall(exp, strm)
		     if ok then
		       table.insert(list, res)
		     else
		       return error(res)
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
	           return parse_error("no valid alternatives", strm)
		 end)
end

function bind(exp, func)
  if not exp then error("nil expression") end
  if type(func) == "function" then func = { func } end
  local funcs = { exp, unpack(func) }
  return function (strm)
	   local tree = strm
	   for _, f in ipairs(funcs) do
	     tree = f(tree)
	   end
	   return tree
	 end
end

function handle(exp, func)
  if not exp then error("nil expression") end
  func = func or function (strm, err) strm:log_error(err); error(err) end
  return function (strm)
	   local ok, res = pcall(exp, strm)
   	   if ok then return res else return func(strm, res) end
	 end
end
