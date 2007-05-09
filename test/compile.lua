require"stream.string"
require"stream.file"
--require"std.base"

local luap = require"cheese.luap"
local ast = require"cheese.luanetc.tie_refs"
local Compiler = require"cheese.luanetc.compiler"

local file = io.open(select(1, ...), "rb")
local parsed_ast = luap.parser.Chunk(stream.file.new(file))
ast.tie_refs(nil, parsed_ast)
local compiler = Compiler.new("foo")
compiler:compile(parsed_ast)
compiler:output()
file:close()

