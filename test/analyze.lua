local luap = require"cheese.luap"
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
print(pcall(luap.parser.SPACING, strm))
print(pcall(luap.parser.LocalDef, strm))
print(pcall(luap.parser.ASSIGN, strm))
print(pcall(luap.parser.NAME, strm))
print(pcall(luap.parser.FuncArgs, strm))
print(string.sub(strm.str, strm.position, strm.position+30))

repeat
  ok, res = pcall(luap.parser.Stat, strm)
  if ok then print(dumper.dump(res)) end
until not ok
print(res.msg, res.state)
print(res.state)
end