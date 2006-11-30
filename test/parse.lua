local parser = require"cheese.luap"
local stream = require"stream.string"
require"std.base"

--tostring = prettytostring

local file = io.open("../src/luap/luap.lua")
local str = file:read("*all")
file:close()

--print(parser.Chunk(stream.new(str)))

--for i=1,10 do
-- parser.Chunk(stream.new(str))
--  foo = loadstring(str)
--end

local strm = stream.new(str)
local ok, res = pcall(parser.Chunk, strm)

print(prettytostring(res))
if not ok then
  print(string.sub(res.stream.str, res.stream.position, res.stream.position+20))
end
