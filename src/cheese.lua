module("cheese", package.seeall)

function str(s)
	 return function (strm)
	 	local state = strm.state
		local ss = strm:gets(string.len(s))
		if (not ss) or (s ~= ss) then
		   strm:backtrack(state)
		   return false
  	        end
	     	return s
	 end
end

function class(...)
	 local args = {...}
	 return function (strm)
	 	local state = strm.state
	 	local c = strm:getc()
		if not c then
		   strm:backtrack(state)
		   return false
		end
	 	for i = 1, #args, 2 do
		    if (c >= args[i]) and (c <= args[i+1]) then
		       return c
		    end
		end
		strm:backtrack(state)
		return false
	 end
end

any = function (strm)
    return strm:getc()
end

function opt(exp)
	 return function (strm)
	 	local res = exp(strm)
		if res then
		    return res
		else
		    return true
		end
	 end
end

function star(exp)
	 return function (strm)
	 	local list = {}
	 	local res = exp(strm)
		while res do
		      table.insert(list, res)
		      res = exp(strm)
		end
		return list
	 end
end

function plus(exp)
	 return function (strm)
	 	local list = {}
		local res = exp(strm)
		if not res then return false end
		repeat
		    table.insert(list, res)
		    res = exp(strm)
		until not res
		return list
	end
end

function pand(exp)
	 return function (strm)
	 	local state = strm.state
		local res = exp(strm)
		strm:backtrack(state)
		return toboolean(res)
	 end
end

function pnot(exp)
	return function (strm)
	 	local state = strm.state
		local res = exp (strm)
		strm:backtrack(state)
		if res then
		   return false
		else
		   return true
		end
	end
end

function seq(...)
	 local args = {...}
	 return function (strm)
	 	local state = strm.state
		local list = {}
		for i, exp in ipairs(args) do
		    local res = exp(strm)
		    if res and type(res) ~= "boolean" then
		       table.insert(list, res)
		    elseif not res then
		       strm:backtrack(state)
		       return false
		    end
		end
		return list
	 end
end

function choice(...)
	 local args = {...}
	 return function (strm)
		for i, exp in ipairs(args) do
		    local res = exp(strm)
		    if res then
		       return res
		    end
		end
		return false
	 end
end

function concat(exp)
	 return function(strm)
	 	local res = exp(strm)
		if type(res) == "table" then
		   return table.concat(res)
		else
		   return res
		end
	 end
end

function skip(exp)
	 return function(strm)
	 	if exp(strm) then
		   return true
		else
		   return false
		end
	 end
end

function bind(exp, func)
	 return function(strm)
	 	local res = exp(strm)
		if res then
		   return func(res)
		else
		   return false
		end
	 end
end
