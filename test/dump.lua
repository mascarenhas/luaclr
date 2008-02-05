require"stream.string"
require"stream.file"
--require"std.base"

local luap = require"cheese.luap"
local ast = require"cheese.luanetc.tie_refs"
local dumper = require"cheese.luap.dump"

for _, filename in ipairs({...}) do

local file = io.open(filename, "rb")
local ok, res = xpcall(function ()
  local parsed_ast = luap.parser.Chunk(stream.file.new(file))
--  print(prettytostring(parsed_ast, "  "))
--  ast.tie_refs(nil, parsed_ast)
  print(dumper.dump(parsed_ast))
  parsed_ast = luap.parser.Chunk(stream.string.new(dumper.dump(parsed_ast)))
  print(dumper.dump(parsed_ast))
end, debug.traceback)
file:close()

if not ok then
  print("failed!!! " .. filename)
  if type(res) == "string" then
    print(res)
  else
    for k, v in pairs(res) do 
      print(k,v)
      if type(v) == "table" then
        for k, v in pairs(v) do
	  print(k, v)
        end
      end
    end
  end
end

end