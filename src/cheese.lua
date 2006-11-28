-- Cheese: a PEG parser generator for Lua, in Lua

module("cheese", package.seeall)

local function parse_error(data)
      return error(data)
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

function opt(exp)
	 return memoize(function (strm)
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
	 return memoize(function (strm)
	 	local state
	 	local list = {}
	 	local ok, res = pcall(exp, strm)
		while ok do
		      if #res > 0 then table.insert(list, res) end
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
		    if #res > 0 then table.insert(list, res) end
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
		   return {}
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
		   return {}
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
		    if ok and #res > 0 then
		       table.insert(list, res)
		    elseif not ok then
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
		   return table.concat(res)
		else
		   return res
		end
	 end
end

function skip(exp)
	 return function (strm)
	 	exp(strm)
		return {}
	 end
end

function bind(exp, func)
	 return function (strm)
	 	return func(exp(strm))
	 end
end
