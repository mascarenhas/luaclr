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
    ilgen = self.ilgen, literals = self.literals }
  self.funcs[#self.funcs + 1] = func
  self.current_func = func
  self.ilgen = IlGen:new(self)
  func.literals = {}
  func.n_literals = 0
  func.clr_type = self.namespace .. "." .. "function" .. #self.funcs
  self.ilgen:prologue()
end

function _M:end_function()
  self.current_func.il = self.ilgen.ops
  local ilgen_ctor = IlGen:new(self)
  ilgen_ctor:constructor()
  self.current_func.ctor = ilgen_ctor.ops
  local ilgen_cctor = IlGen:new(self)
  ilgen_cctor:class_constructor()
  self.current_func.cctor = ilgen_cctor.ops
  local top = self.func_stack[#self.func_stack]
  self.func_stack[#self.func_stack] = nil
  self.ilgen = top.ilgen
  self.current_func = top.func
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

function _M:compile(tree)
  codegen.compile(_M, tree)
  for _, func in ipairs(self.funcs) do
    self:output_func(func)
  end
end

