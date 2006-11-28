require"struct"

module("stream.file", package.seeall)

local function count(str, char)
      local c = 0
      local byte = string.byte
      for i = 1, #str do
      	  if byte(str, i) == char then c = c + 1 end
      end
      return c
end

function new(file)
	 return { file = file, line = 1, getc = getc, backtrack = backtrack,
	   gets = gets, memoize = memoize, memoized = memoized, state = state,
	   cache = {} }
end

function getc(strm)
	 local c = strm.file:read(1)
	 if c == "\n" then strm.line = strm.line + 1 end
	 return c
end

function gets(strm, l)
	 local s = strm.file:read(l)
	 if not s or string.len(s) < l then
	    return nil
	 else
	    strm.line = strm.line + count(s, string.byte("\n"))
	    return s
	 end
end

function state(strm)
	 return struct.pack("ii", strm.file:seek(), strm.line)
end

function backtrack(strm, st)
	 local position, line = struct.unpack("ii", st)
	 strm.file:seek("set", position)
	 strm.line = line
end

function memoize(strm, st, res)
	 strm.cache[st] = res
end

function memoized(strm)
	 return strm.cache[strm:state()]
end
