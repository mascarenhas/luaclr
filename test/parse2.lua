local parser = require"cheese.luap"
local stream = require"stream.string"
require"std.base"

parser=parser.parser


print(parser.FUNCTION)

local strm = stream.new("function () return foo end")
print("foo")
local ok, res = pcall(parser.FUNCTION,(strm))
print(ok, res)
print(parser.FUNCTION(strm))
print(parser.LPAR(strm))
print(parser.RPAR(strm))
print(parser.Block(strm))
--print(parser.AnonFunction(strm))
--local ok, res = pcall(parser.ExpList1, strm)
--print(ok, res)
--print(string.sub(res.stream.str, res.stream.position, res.stream.position+10))
