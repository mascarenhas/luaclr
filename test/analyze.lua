local parser = require"cheese.luap"
local stream = require"stream.string"
local dumper = require"cheese.luap.dump"


for _, filename in ipairs({...}) do

local file = io.open(filename)
local str = file:read("*all")
file:close()

local strm = stream.new(str)
local ok, res
--print(pcall(parser.Exp,(strm)))
--print()
print(pcall(parser.SPACING, strm))
repeat
  ok, res = pcall(parser.Stat, strm)
  if ok then print(dumper.dump(res)) end
until not ok
print(res.msg, res.state)
print(res.state)
end