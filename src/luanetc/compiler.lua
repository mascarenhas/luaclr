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
  func.ret_type = "single"
  self.ilgen:prologue()
end

function _M:end_function()
  local func = self.current_func
  func.invokeS = {}
  func.invokeM = {}
  if func.isvararg then
    func.invokeS["vararg"] = self.ilgen.ops
  else
    func.invokeS[#func.args] = self.ilgen.ops
  end
  func.ret_type = "multi"
  self.ilgen = IlGen.new(self)
  self:compile(func.block)
  self.ilgen:argslist({ "nil" }, "array")
  self.ilgen:emit(OpCodes.ret)
  if func.isvararg then
    func.invokeM["vararg"] = self.ilgen.ops
  else
    func.invokeM[#func.args] = self.ilgen.ops
  end
  for i = 0, IlGen.max_args do
    if func.isvararg or i ~= #func.args then
      local ilgen = IlGen.new(self)
      ilgen:invoke(func.clr_type, i, #func.args, "object", "InvokeS",
		   func.isvararg)
      func.invokeS[i] = ilgen.ops
      local ilgen = IlGen.new(self)
      ilgen:invoke(func.clr_type, i, #func.args, "object[]", "InvokeM",
		 func.isvararg)
      func.invokeM[i] = ilgen.ops
    end
  end
  if (not func.isvararg) or (#func.args > 0) then
    local ilgen_array = IlGen.new(self)
    ilgen_array:invoke(func.clr_type, "array", #func.args, "object",
		       "InvokeS")
    func.invokeS["array"] = ilgen_array.ops
    local ilgen_array = IlGen.new(self)
    ilgen_array:invoke(func.clr_type, "array", #func.args, "object[]", 
		     "InvokeM")
    func.invokeM["array"] = ilgen_array.ops
  end
  local ilgen_ctor = IlGen.new(self)
  ilgen_ctor:constructor()
  func.ctor = ilgen_ctor.ops
  local ilgen_cctor = IlGen.new(self)
  ilgen_cctor:class_constructor()
  func.cctor = ilgen_cctor.ops
  func.compiled = true
  local top = self.func_stack[#self.func_stack]
  self.func_stack[#self.func_stack] = nil
  self.ilgen = top.ilgen
  self.current_func = top.func
  return func
end

function _M:get_literal(lit)
  local func = self.current_func
  if not lit then
    return "object " .. func.clr_type .. "::LiteralNil"
  else
    if func.literals[lit] then
      return "object " .. func.clr_type .. "::" .. func.literals[lit]
    else
      func.n_literals = func.n_literals + 1
      local new_lit = "Literal" .. func.n_literals
      func.literals[lit] = new_lit
      return "object " .. func.clr_type .. "::" .. new_lit
    end
  end
end

local function print_op(opcode, arg, func_type)
  if opcode == "label" then
    io.write(arg .. ":")
  else
    io.write("        ")
    io.write(opcode)
    io.write(" ")
    if opcode ~= "box"  and opcode:match("^b") then
      io.write("label" .. arg)
    elseif type(arg) == "table" then
      if opcode == "ldfld" or opcode == "stfld" and arg.isupval then
	io.write("class [lua]Lua.UpValue " .. func_type .. "::" .. arg.name)
      else
        io.write(arg.name)
      end
    elseif opcode == "ldstr" then
      io.write(string.format("%q", arg))
    elseif arg then
      io.write(arg)
    end
  end
  io.write("\n")
end

local function print_class_header(type) 
  print(".class public auto ansi beforefieldinit " .. type ..
	" extends [lua]Lua.Closure")
end

local function print_literal(type, lit)
  lit = lit:gsub(type .. "::", "")
  print("  .field public static object " .. lit)
end

local function print_upvalue(func_type, upval)
  print("  .field public class [lua]Lua.UpValue " .. upval.name)
end

local function print_method_name(func, nargs, ret_type, invoke_name)
  if nargs ~= "array" then
    local args = {}
    local vararg
    if nargs == "vararg" then
      nargs = #func.args
      vararg = "object[]"
    end
    for i = 1, nargs do
      if #func.args == nargs then
        args[#args + 1] = "object " .. func.args[i].name
      else
        args[#args + 1] = "object"
      end
    end
    args[#args + 1] = vararg
    print("  .method public hidebysig virtual instance " .. 
	  ret_type .. " " .. invoke_name .. "(" ..
	  table.concat(args, ", ") ..  ") cil managed")
  else
    print("  .method public hidebysig virtual instance " ..
	  ret_type .. " " .. invoke_name .. 
	    "(object[]) cil managed")
  end
end

local function print_locals(locals)
  local tab = {}
  for _, l in ipairs(locals) do
    if l.isupval then
      tab[#tab + 1] = "class [lua]Lua.UpValue " .. l.name 
    else 
      local ltype = l.type or "object"
      tab[#tab + 1] = ltype .. " " .. l.name
    end
  end
  print("        .locals init (" .. table.concat(tab, ", ") .. ")")
end

function _M:output_func(func)
  print_class_header(func.clr_type)
  print("{")
  print_literal(func.clr_type, "LiteralNil")
  for k, v in pairs(func.literals) do
    print_literal(func.clr_type, v)
  end
  for upval, _ in pairs(func.upvals) do
    print_upvalue(func.clr_type, upval)
  end
  print("  .method private hidebysig specialname rtspecialname " .. 
	"static void .cctor() cil managed")
  print("  {")
  print("  .locals init (object V_0)")
  for _, op in ipairs(func.cctor) do
    print_op(op[1], op[2])
  end
  print("  }")
  print("  .method public hidebysig specialname rtspecialname " .. 
	"instance void " .. func.ctor_name .. " cil managed")
  print("  {")
  for _, op in ipairs(func.ctor) do
    print_op(op[1], op[2], func.clr_type)
  end
  print("  }")
  for i, ops in pairs(func.invokeS) do
    print_method_name(func, i, "object", "InvokeS")
    print("  {")
    if #func.args == i then
      print("        .maxstack 12")
      print_locals(func.locals)
    elseif i == "array" then
      print("        .locals init (int32 V_0)")
    end
    for _, op in ipairs(ops) do
      print_op(op[1], op[2], func.clr_type)
    end
    print("  }")
  end
  for i, ops in pairs(func.invokeM) do
    print_method_name(func, i, "object[]", "InvokeM")
    print("  {")
    if #func.args == i then
      print("        .maxstack 12")
      print_locals(func.locals)
    elseif i == "array" then
      print("        .locals init (int32 V_0)")
    end
    for _, op in ipairs(ops) do
      print_op(op[1], op[2], func.clr_type)
    end
    print("  }")
  end
  print("}")
  print()
end

function _M:compile(tree, ...)
  codegen.compile(self, tree, ...)
end

function _M:output()
  print(".assembly extern lua")
  print("{")
  print("  .ver 0:0:0:0")
  print("}")
  print(".assembly fib {}")
  for _, func in ipairs(self.funcs) do
    self:output_func(func)
  end
end