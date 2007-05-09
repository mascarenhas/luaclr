local OpCodes = require "cheese.luanetc.opcodes"
local IlGen = require "cheese.luanetc.ilgen"
local codegen = require "cheese.luanetc.codegen"

module(..., package.seeall)

function new(namespace)
  local compiler = { func_stack = {}, funcs = {}, namespace = namespace }
  setmetatable(compiler, { __index = _M })
  return compiler
end

function _M:start_function(func)
  self.func_stack[#self.func_stack + 1] = { func = self.current_func, 
    ilgen = self.ilgen }
  self.funcs[#self.funcs + 1] = func
  self.current_func = func
  self.ilgen = IlGen.new(self)
  func.literals = {}
  func.n_literals = 0
  func.clr_type = self.namespace .. "." .. "function" .. #self.funcs
  self.ilgen:prologue()
end

function _M:end_function()
  local func = self.current_func
  func.invoke = {}
  func.invoke[#func.args] = self.ilgen.ops
  for i = 0, IlGen.max_args do
    if i ~= #func.args then
      local ilgen = IlGen.new(self)
      ilgen:invoke(i, #func.args)
      func.invoke[i] = ilgen.ops
    end
  end
  local ilgen_array = IlGen.new(self)
  ilgen_array:invoke("array", #func.args)
  func.invoke["array"] = ilgen_array.ops
  local ilgen_ctor = IlGen.new(self)
  ilgen_ctor:constructor()
  func.ctor = ilgen_ctor.ops
  local ilgen_cctor = IlGen.new(self)
  ilgen_cctor:class_constructor()
  func.cctor = ilgen_cctor.ops
  local top = self.func_stack[#self.func_stack]
  self.func_stack[#self.func_stack] = nil
  self.ilgen = top.ilgen
  self.current_func = top.func
  return func
end

function _M:get_literal(lit)
  local func = self.current_func
  if not lit then
    return "Lua.Value " .. func.clr_type .. "::LiteralNil"
  else
    if func.literals[lit] then
      return "Lua.Value " .. func.clr_type .. "::" .. func.literals[lit]
    else
      func.n_literals = func.n_literals + 1
      local new_lit = "Literal" .. func.n_literals
      func.literals[lit] = new_lit
      return "Lua.Value " .. func.clr_type .. "::" .. new_lit
    end
  end
end

local function print_op(opcode, arg)
  if opcode == "label" then
    io.write(arg .. ":")
  else
    io.write("        ")
    io.write(opcode)
    io.write(" ")
    if opcode:match("^b") then
      io.write("label" .. arg)
    elseif type(arg) == "table" then
      io.write("'" .. (arg.name or tostring(arg)) .. "'")
    elseif arg then
      io.write(arg)
    end
  end
  io.write("\n")
end

function _M:output_func(func)
  print(func.clr_type)
  print("literals")
  for k, v in pairs(func.literals) do
    print("  ", k, v)
  end
  print("fields")
  for upval, _ in pairs(func.upvals) do
    print("  ", upval)
  end
  print("class ctor")
  for _, op in ipairs(func.cctor) do
    print_op(op[1], op[2])
  end
  print(func.ctor_name)
  for _, op in ipairs(func.ctor) do
    print_op(op[1], op[2])
  end
  for i, ops in pairs(func.invoke) do
    print("body with " .. i .. " args")
    for _, op in ipairs(ops) do
      print_op(op[1], op[2])
    end
  end
  print()
end

function _M:compile(tree, ...)
  codegen.compile(self, tree, ...)
end

function _M:output()
  print(#self.funcs)
  for _, func in ipairs(self.funcs) do
    self:output_func(func)
  end
end