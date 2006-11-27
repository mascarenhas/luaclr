module("stream.string", package.seeall)

function new(str)
	 return { str = str, state = 1, getc = getc, backtrack = backtrack,
	   gets = gets }
end

function getc(strm)
	 if strm.state > string.len(strm.str) then
	    return false
	 else
	    local c = string.sub(strm.str, strm.state, strm.state)
	    strm.state = strm.state + 1
	    return c
	 end
end

function gets(strm, l)
	 local start, finish = strm.state, strm.state + l - 1
	 if finish > string.len(strm.str) then
	    return false
	 else
	    strm.state = finish + 1
	    return string.sub(strm.str, start, finish)
	 end
end

function backtrack(strm, state)
	 strm.state = state
end
