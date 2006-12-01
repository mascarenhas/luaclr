local parser = require"cheese.luap"
local stream = require"stream.string"
local dumper = require"cheese.luap.dump"
--require"std.base"

--tostring = prettytostring

local file = io.open("../luap.lua")
local str = file:read("*all")
file:close()

print(dumper.dump(parser.Chunk(stream.new(str))))

--for i=1,10 do
-- parser.Chunk(stream.new(str))
--  foo = loadstring(str)
--end

--local strm = stream.new(str)
--local ok, res
--repeat
--  ok, res = pcall(parser.Stat, strm)
--  if ok then print(dumper.dump(res)) end
--until not ok
--print(res.state, res.msg)
--print(dumper.dump(res))
--if not ok then
--  print(strm.errors)
--  strm:backtrack(res.state)
--  print(string.sub(stream.str, stream.position, stream.position+20))
--end


