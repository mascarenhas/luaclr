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
	   gets = get, state = state, errors = {} }
end

function log_error(strm, err)
  local err_data
  if type(err) == "table" then
    local position, line = struct.unpack("ii", err.state)
    err_data = { msg = err.msg, position = position, line = line }
  else
    err_data = { msg = err, position = strm.file:seek(), line = strm.line }
  end
  table.insert(strm.errors, err_data)
end

function getc(strm)
	 local c = strm.file:read(1)
 	 if not c then error("end of stream") end
	 if c == "\n" then strm.line = strm.line + 1 end
	 return c
end

function gets(strm, l)
	 local s = strm.file:read(l)
	 if not s or string.len(s) < l then
   	    error("end of stream")
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

