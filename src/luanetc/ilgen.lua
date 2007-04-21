local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

luavalue_type = "Lua.Value"
luavalue_ref = "Lua.Refrence Lua.Value::O"
luavalue_val = "double Lua.Value::N"
int4_type = "int32"
array_copy = "[mscorlib]System.Array::Copy(System.Array,int32,System.Array,int32,int32)"
env_field = "Lua.Value Lua.Closure::Env"
closure_cons = "Lua.Closure::.ctor()"

nil_singleton = "Lua.Reference Lua.Nil::Instance"
false_singleton = "Lua.Reference Lua.False::Instance"
true_singleton = "Lua.Reference Lua.True::Instance"

function new(compiler)
  local ilgen = { ops = {}, labels = {}, loops = {}, 
    temps = {}, compiler = compiler }
  setmetatable(ilgen, { __index = _M })
  return ilgen
end

function _M:jump_if_false(to)
  local temp = self:get_temp()
  self:store_local(temp)
  self.load_local(temp)
  self:emit(OpCodes.ldfld, luavalue_ref)
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.beq, to)
  self:load_local(temp)
  self:emit(OpCodes.ldfld, luavalue_ref)
  self:emit(OpCodes.ldsfld, false_singleton)
  self:emit(OpCodes.beq, to)
  self:release_temp(temp)
end

function _M:jump_if_nil(to)
  self:emit(OpCodes.ldfld, luavalue_ref)
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.beq, to)
end

function _M:define_label()
  local label = #self.labels + 1
  self.labels[label] = "label" .. label
  return label
end

function _M:mark_label(label)
  self.ops[#self.ops + 1] = { "label", self.labels[label] }
end

function _M:start_loop()
  local label = self:define_label()
  self.loops[#self.loops + 1] = label
end

function _M:end_loop()
  self.loops[#self.loops] = nil
end

function _M:break_loop()
  self:emit(OpCodes.br, self.loops[#self.loops])
end

function _M:store_local(localvar)
  if localvar.isupval then
    if localvar.func == self.compiler.current_func then
      self:store_local(localvar.temp)
      self:emit(OpCodes.ldloc, localvar)
      self.emit(OpCodes.ldc_i4_0)
      self:load_local(localvar.temp)
      self:emit(OpCodes.stelem, luavalue_type)
    else
      self:store_local(localvar.temp)
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, localvar)
      self.emit(OpCodes.ldc_i4_0)
      self:load_local(localvar.temp)
      self:emit(OpCodes.stelem, luavalue_type)
    end
  elseif localvar.isarg then
    self:emit(OpCodes.starg, localvar)
  else
    self:emit(OpCodes.stloc, localvar)
  end
end

function _M:load_local(localvar)
  if localvar.isupval then
    if localvar.func == self.compiler.current_func then
      self:emit(OpCodes.ldloc, localvar)
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.ldelem, luavalue_type)
    else
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, localvar)
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.ldelem, luavalue_type)
    end
  elseif localvar.isarg then
    self:emit(OpCodes.ldarg, localvar)
  else
    self:emit(OpCodes.ldloc, localvar)
  end
end

function _M:get_temp(type)
  type = type or luavalue_type
  if not self.temps[type] then
    self.temps[type] = {}
  end
  local temps = self.temps[type]
  if #temps > 0 then
    local temp = temps[#temps]
    temps[#temps] = nil
    return temp
  else
    local func = self.compiler.current_func
    local new_temp = { name = "temp_" .. #func.locals,
      func = func, type = type }
    func.locals[#func.locals + 1] = new_temp
    return new_temp
  end
end

function _M:release_temp(temp)
  if not self.temps[temp.type] then
    self.temps[temp.type] = {}
  end
  local temps = self.temps[temp.type]
  temps[#temps + 1] = temp
end

function _M:jump_if_not_equal(gen_op1, gen_op2, to)
end

function _M:add(gen_op1, gen_op2)
end

function _M:add_number(gen_op1, n)
end

function _M:argslist(list, return_array)
  if #list > self.compiler.max_args then return_array = true end
  local temp = self:get_temp(luavalue_array_type)
  local last = list[#list]
  if last and last.tag == "call" then
    if #list == 1 then
      self.compiler:compile(last)
      return nil
    end
    return_array = true
    list[#list] = nil
    local size = self:get_temp(int4_type)
    self.compiler:compile(last)
    self:store_local(temp)
    self:load_local(temp)
    self:emit(OpCodes.ldlen)
    self:store_local(size)
    self:load_local(temp)
    self:emit(opcodes.ldc_i4_0)
    self:load_local(size)
    self:emit(OpCodes.ldc_i4, #list)
    self:emit(OpCodes.add)
    self:emit(OpCodes.newarr, luavalue_type)
    self:store_local(temp)
    self:load_local(temp)
    self:emit(OpCodes.ldc_i4, #list)
    self:load_local(size)
    self:emit(OpCodes.call, array_copy)
    self:release_temp(size)
  elseif return_array then
    self:emit(OpCodes.ldc_i4, #list)
    self:emit(OpCodes.newarr, luavalue_type)
    self:store_local(temp)
  end
  if return_array then
    for i = 1, #list do
      self:load_local(temp)
      self:emit(OpCodes.ldc_i4, i - 1)
      self.compiler:compile(list[i])
      if list[i].tag == "call" then
        self:emit(OpCodes.ldc_i4_0)
        self:emit(OpCodes.ldelem, luavalue_type)
      end
      self:emit(OpCodes.stelem, luavalue_type)
    end
    self:load_local(temp)
    return nil
  else
    for i = 1, #list do
      self.compiler:compile(list[i])
      if list[i].tag == "call" then
        self:emit(OpCodes.ldc_i4_0)
        self:emit(OpCodes.ldelem, luavalue_type)
      end
    end
    return #list
  end
  self:release_temp(temp)
end

function _M:explist(list, adjust_n)
  local i = 1
  while i < #list and i <= adjust_n do
    self.compiler:compile(list[i])
    if list[i].tag == "call" then
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.ldelem, luavalue_type)
    end
    i = i + 1
  end
  if i <= adjust_n then
    self.compiler:compile(list[i])
    if list[i].tag == "call" then
      local temp = self:get_temp(IlGen.luavalue_array_type)
      local size = self:get_temp(IlGen.int4_type)
      self:store_local(temp)
      self:load_local(temp)
      self:emit(OpCodes.ldlen)
      self:store_local(size)
      for i = 0, (adjust_n - i) do
	local load_nil = self:define_label()
	local next = self_define_label()
	self:emit(OpCodes.ldc_i4, i)
	self:load_local(size)
	self:emit(OpCodes.bge, load_nil)
	self:load_local(temp)
	self:emit(OpCodes.ldc_i4, i)
	self:emit(OpCodes.ldelem, luavalue_type)
	self:emit(OpCodes.br, next)
	self:mark_label(load_nil)
	self:emit(OpCodes.ldsfld, nil_singleton)
	self:mark_label(next)
      end
      self:release_temp(temp)
      self:release_temp(size)
    else
      for i = (i + 1), adjust_n do
	self:emit(OpCodes.ldsfld, nil_singleton)
      end
    end    
  end
end

function _M:store_global(name)
  local temp = self:get_temp()
  self:store_local(temp)
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.ldfld, env_field)
  self:load_string(name)
  self:load_local(temp)
  self:settable()
  self:release_temp(temp)
end

function _M:load_global(name)
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.ldfld, env_field)
  self:load_string(name)
  self:gettable()
end

function _M:settable()
  self:emit(OpCodes.call, gettable_method)
end

function _M:gettable()
  self:emit(OpCodes.call, settable_method)
end

function _M:load_string(name)
  self:emit(OpCodes.ldsfld, self.compiler:get_literal(name))
end

function _M:load_number(n)
  self:emit(OpCodes.ldsfld, self.compiler:get_literal(n))
end

function _M:load_nil()
  self:emit(OpCodes.ldsfld, self.compiler:get_literal())
end

function _M:load_true()
  self:emit(OpCodes.ldsfld, self.compiler:get_literal(true))
end

function _M:load_false()
  self:emit(OpCodes.ldsfld, self.compiler:get_literal(false))
end

function _M:call(nres, nargs)
  if not nargs then
    self:emit(OpCodes.call, call_with_array)
  else
    self:emit(OpCodes.call, call_with[nargs])
  end
end

function _M:emit(opcode, ...)
  self.ops[#self.ops + 1] = { opcode, ... }
end

function _M:new_func(func)
  for upval, _ in pairs(func.upvals) do
    if upval.func == self.current_func then
      self:emit(OpCodes.ldloc, upval)
    else
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, upval)
    end
  end
  self:emit(OpCodes.newobj, func.clr_type .. "::" .. func.ctor_name)
end

function _M:prologue()
  local func = self.compiler.current_func
  local args, locals = func.args, func.locals
  for _, var in ipairs(locals) do
    if var.isupval then
      self:emit(OpCodes.ldc_i4_1)
      self:emit(OpCodes.newarr, luavalue_type)
      self:emit(OpCodes.stloc, var)
      var.temp = self:get_temp()
    end
  end
  for _, arg in ipairs(args) do
    if arg.isupval then
      locals[#locals + 1] = arg
      self:emit(OpCodes.ldc_i4_1)
      self:emit(OpCodes.newarr, luavalue_type)
      self:emit(OpCodes.stloc, arg)
      self:emit(OpCodes.ldloc, arg)
      self:emit(OpCodes.ldc_i4_1, arg)
      self:emit(OpCodes.ldarg, arg)
      self:emit(OpCodes.stelem, luavalue_type)
      arg.isarg = false
    end
  end
end

function _M:constructor()
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.call, closure_cons)
  local func = self.compiler.current_func
  local args = {}
  for upval, _ in pairs(func.upvals) do
    args[#args + 1] = "Lua.Value[] " + upval.name
    self:emit(OpCodes.ldarg_0)
    self:emit(OpCodes.ldarg, #args)
    self:emit(OpCodes.stfld, upval)
  end
  self:emit(OpCodes.ret)
  func.ctor_name = ".ctor(" .. table.concat(args, ", ") .. ")"
end

function _M:class_constructor()
  for val, _ in pairs(func.literals) do
    self:emit(OpCodes.ldsflda, self.compiler:get_literal(val))
    if type(val) == "boolean" then
      if val then
	self:emit(OpCodes.ldsfld, true_singleton)
      else
	self:emit(OpCodes.ldsfld, false_singleton)
      end
      self:emit(OpCodes.stfld, luavalue_ref)
    elseif type(val) == "number" then
      self:emit(OpCodes.ldc_r8, val)
      self:emit(OpCodes.stfld, luavalue_val)
    else
      self:emit(OpCodes.ldstr, val)
      self:emit(OpCodes.stfld, luavalue_ref)
  end
  self:emit(OpCodes.ldsflda, self.compilet:get_literal())
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.stfld, luavalue_ref)
  self:emit(OpCodes.ret)
end
