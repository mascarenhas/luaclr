require"stream.string"
require"stream.file"

local luap = require"cheese.luap"
local ast = require"cheese.luanetc.tie_refs"
local types = require"cheese.luanetc.type_prop"
local Compiler = require"cheese.luanetc.compiler"

local file = io.open(select(1, ...), "rb")
local namespace = (...):match("([^\\%.]+)%.")
local parsed_ast = luap.parser.Chunk(stream.file.new(file))
ast.tie_refs(nil, parsed_ast)
types.infer(parsed_ast)
local compiler = Compiler.new(namespace)
compiler:compile(parsed_ast)
compiler:output()
file:close()
