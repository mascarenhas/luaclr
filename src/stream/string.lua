require"struct"

module("stream.string", package.seeall)

local function count(str, char)
      local c = 0
      local byte = string.byte
      for i = 1, #str do
      	  if byte(str, i) == char then c = c + 1 end
      end
      return c
end

function new(str)
	 return { str = str, position = 1, line = 1, getc = getc, backtrack = backtrack,
	   gets = gets, state = state, errors = {} }
end

function log_error(strm, err)
  local err_data
  if type(err) == "table" then
    local position, line = struct.unpack("ii", err.state)
    err_data = { msg = err.msg, position = position, line = line }
  else
    err_data = { msg = err, position = strm.position, line = strm.line }
  end
  table.insert(strm.errors, err_data)
end

function getc(strm)
	 local current = strm.position
	 if current > string.len(strm.str) then
	    return error("end of stream")
	 else
	    local c = string.sub(strm.str, current, current)
	    strm.position = current + 1
	    if c == "\n" then strm.line = strm.line + 1 end
	    return c
	 end
end

function gets(strm, l)
	 local start, finish = strm.position, strm.position + l - 1
	 if finish > string.len(strm.str) then
	    return error("end of stream")
	 else
	    strm.position = finish + 1
	    local s = string.sub(strm.str, start, finish)
	    strm.line = strm.line + count(s, string.byte("\n"))
	    return s
	 end
end

function state(strm)
	 return struct.pack("ii", strm.position, strm.line)
end

function backtrack(strm, st)
	 local position, line = struct.unpack("ii", st)
	 strm.position = position
	 strm.line = line
end

