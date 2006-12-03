require"stream.string"
require"stream.file"

local luap = require"cheese.luap"
local dumper = require"cheese.luap.dump"

for _, filename in ipairs({...}) do

local file = io.open(filename)
local ok, res = pcall(function ()
local dump = dumper.dump(luap.parser.Chunk(stream.file.new(file)))
local dump2 = dumper.dump(luap.parser.Chunk(stream.string.new(dump)))
print(dump == dump2)
end)
file:close()

if not ok then print("failed!!! " .. filename) end

end