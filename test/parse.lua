local parser = require"cheese.luap"
local stream = require"stream.string"
local dumper = require"cheese.luap.dump"


for _, filename in ipairs({...}) do

local file = io.open(filename)
local str = file:read("*all")
file:close()
local ok, res = pcall(function ()
local dump = dumper.dump(parser.Chunk(stream.new(str)))
local dump2 = dumper.dump(parser.Chunk(stream.new(dump)))
print(dump == dump2)
end)

if not ok then print("failed!!! " .. filename) end

end