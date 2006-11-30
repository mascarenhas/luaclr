local parser = require"cheese.luap"
local stream = require"stream.string"
require"std.base"

local strm = stream.new("function () return foo end")

print(parser.FUNCTION(strm))
print(parser.LPAR(strm))
print(parser.RPAR(strm))
print(parser.Block(strm))
--print(parser.AnonFunction(strm))
--local ok, res = pcall(parser.ExpList1, strm)
--print(ok, res)
--print(string.sub(res.stream.str, res.stream.position, res.stream.position+10))