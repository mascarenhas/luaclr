-- Cheese: a PEG parser generator for Lua, in Lua

module("cheese", package.seeall)

local function parse_error(data)
      return error(data)
end

local function flatten
flatten = function(tab)
	if type(tab) == "string" then return tab end
	if not tab then return "" end
	return table.concat(table.map(tab, flatten))
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
		 res = func(strm)
		 strm_cache[state] = res	 
	     else
	         res = strm_cache[state] 
	     	 if not res then
	     	    res = func(strm)
		    strm_cache[state] = res
		 end
	     end
	     return res
      end
end

function char(c)
	return memoize(funtion (strm)
	 	local cc = strm:getc()
		if cc == c then
		   return cc
		else
		   return parse_error({tag = "char", stream = strm, class = args})
		end
	end)
end

function str(s)
	 return memoize(function (strm)
		local ss = strm:gets(string.len(s))
		if (not ss) or (s ~= ss) then
		   return parse_error({tag = "string", stream = strm, string = s})
  	        end
	     	return s
	 end)
end

function class(...)
	 local args = {...}
	 return memoize(function (strm)
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
	 end)
end

any = memoize(function (strm)
    return strm:getc()
end)

digit = class("0", "9")

function opt(exp)
	 return memoize(function (strm)
	 	local state = strm:state()
	 	local ok, res = pcall(exp, strm)
		if ok then
		    return res
		else
		    strm:backtrack(state)
		    return nil
		end
	 end)
end

function star(exp)
	 return memoize(function (strm)
	 	local state
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
	 return memoize(function (strm)
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
	end)
end

function pand(exp)
	 return memoize(function (strm)
	 	local state = strm:state()
		local ok, res = pcall(exp, strm)
		strm:backtrack(state)
		if ok then
		   return nil
		else
		   return parse_error(res)
		end
	 end)
end

function pnot(exp)
	return memoize(function (strm)
	 	local state = strm:state()
		local ok, res = pcall(exp, strm)
		strm:backtrack(state)
		if ok then
		   return parse_error({tag = "not", stream = strm})
		else
		   return nil
		end
	end)
end

function seq(...)
	 local args = {...}
	 return memoize(function (strm)
	 	local state = strm:state()
		local list = {}
		for i, exp in ipairs(args) do
		    local ok, res = pcall(exp, strm)
		    if ok then
		       table.insert(list, res)
		    else
		       strm:backtrack(state)
		       return parse_error(res)
		    end
		end
		return list
	 end)
end

function choice(...)
	 local args = {...}
	 return memoize(function (strm)
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
	 return function (strm)
	 	local res = exp(strm)
		if type(res) == "table" then
		   return flatten(res)
		else
		   return res
		end
	 end
end

function skip(exp)
	 return function (strm)
	 	exp(strm)
		return nil
	 end
end

function bind(exp, func)
	 return function (strm)
	 	return func(exp(strm))
	 end
end
