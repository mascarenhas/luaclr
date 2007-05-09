local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

luavalue_type = "Lua.Value"
luavalue_ref = "Lua.Reference Lua.Value::O"
luavalue_val = "double Lua.Value::N"
int4_type = "int32"
array_copy = "[mscorlib]System.Array::Copy(System.Array,int32,System.Array,int32,int32)"
env_field = "Lua.Value Lua.Closure::Env"
closure_cons = "Lua.Closure::.ctor()"
string_cons = "Lua.String::.ctor(string)"
table_cons = "Lua.Table::.ctor()"

nil_singleton = "Lua.Reference Lua.Nil::Instance"
false_singleton = "Lua.Reference Lua.False::Instance"
true_singleton = "Lua.Reference Lua.True::Instance"

gettable_method = "Lua.Value::get_Index(Lua.Value)"
settable_method = "Lua.Value::set_Index(Lua.Value, Lua.Value)"
neg_method = "Lua.Reference::Negate(Lua.Value)"
len_method = "Lua.Value::Length(Lua.Value)"
arith_method = {
  add = "Lua.Reference::Add(Lua.Value, Lua.Value)",
  sub = "Lua.Reference::Subtract(Lua.Value, Lua.Value)",
  mul = "Lua.Reference::Multiply(Lua.Value, Lua.Value)",
  div = "Lua.Reference::Divide(Lua.Value, Lua.Value)",
  mod = "Lua.Reference::Mod(Lua.Value, Lua.Value)",
  exp = "Lua.Reference::Pow(Lua.Value, Lua.Value)"
}
arith_method_slow = {
  add = "Lua.Reference::Add(double, Lua.Value)",
  sub = "Lua.Reference::Subtract(double, Lua.Value)",
  mul = "Lua.Reference::Multiply(double, Lua.Value)",
  div = "Lua.Reference::Divide(double, Lua.Value)",
  mod = "Lua.Reference::Mod(double, Lua.Value)",
  exp = "Lua.Reference::Pow(double, Lua.Value)"
}
rel_method = {
  beq = "Lua.Reference::Equal(Lua.Value, Lua.Value)",
  bne = "Lua.Reference::NotEqual(Lua.Value, Lua.Value)",
  blt = "Lua.Reference::LessThan(Lua.Value, Lua.Value)",
  bgt = "Lua.Reference::GreaterThan(Lua.Value, Lua.Value)",
  ble = "Lua.Reference::LessThanOrEqual(Lua.Value, Lua.Value)",
  bge = "Lua.Reference::GreaterThanOrEqual(Lua.Value, Lua.Value)"
}

max_args = 7
call_with_array = "Lua.Value::Invoke(Lua.Value, Lua.Value[])"
local call_with = {}
setmetatable(call_with, {
  __index = function (tab, i)
	      local args = {}
	      for j = 1, i do args[#args + 1] = "Lua.Value" end
	      return "Lua.Value::Invoke(" .. table.concat(args, ", ") .. ")"
	    end })

function new(compiler)
  local ilgen = { ops = {}, labels = {}, loops = {}, 
    temps = {}, compiler = compiler }
  setmetatable(ilgen, { __index = _M })
  return ilgen
end

function _M:jump_if_false(to)
  local temp = self:get_temp()
  self:store_local(temp)
  self:load_local(temp)
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
      self:emit(OpCodes.ldc_i4_0)
      self:load_local(localvar.temp)
      self:emit(OpCodes.stelem, luavalue_type)
    else
      self:store_local(localvar.temp)
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, localvar)
      self:emit(OpCodes.ldc_i4_0)
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

function _M:jump_if_not_equal(exp1, exp2, to)
  self:rel("beq", exp1, exp2)
  self:jump_if_false(to)
end

function _M:neg(exp)
  local retval = self:get_temp()  
  local slow_track = self:define_label()
  local out = self:define_label()
  self:load_local(retval)
  self:emit(OpCodes.ldflda, luavalue_val)
  self.compiler:compile(exp)
  self:emit(OpCodes.dup)
  self:emit(OpCodes.ldfld, luavalue_ref)
  self:emit(OpCodes.brtrue, slow_track)
  self:emit(OpCodes.ldfld, luavalue_val)
  self:emit(OpCodes.neg)
  self:emit(OpCodes.stind_r8)
  self:emit(OpCodes.br, out)
  self:mark_label(slow_track)
  self:emit(OpCodes.call, neg_method)
  self:store_local(retval)
  self:emit(OpCodes.pop)
  self:emit(OpCodes.br, out)
  self:mark_label(out)
  self:load_local(retval)
  self:release_temp(retval)
end

function _M:arith(op, exp1, exp2)
  local retval = self:get_temp()  
  local slow_track = self:define_label()
  local very_slow_track = self:define_label()
  local out = self:define_label()
  self:load_local(retval)
  self:emit(OpCodes.ldflda, luavalue_val)
  if type(exp1) == "number" then
    self:emit(OpCodes.ldc_r8, exp1)
  elseif exp1.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp1.val)
  else
    self.compiler:compile(exp1)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.ldfld, luavalue_ref)
    self:emit(OpCodes.brtrue, slow_track)
    self:emit(OpCodes.ldfld, luavalue_val)
  end
  if type(exp2) == "number" then
    self:emit(OpCodes.ldc_r8, exp2)
  elseif exp2.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp2.val)
  else
    self.compiler:compile(exp2)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.ldfld, luavalue_ref)
    self:emit(OpCodes.brtrue, very_slow_track)
    self:emit(OpCodes.ldfld, luavalue_val)
  end
  self:emit(op)
  self:emit(OpCodes.stind_r8)
  self:emit(OpCodes.br, out)
  if type(exp1) ~= "number" and exp1.tag ~= "number" then
    self:mark_label(slow_track)
    self.compiler:compile(exp2)
    self:emit(OpCodes.call, arith_method[op])
    self:store_local(retval)
    self:emit(OpCodes.pop)
    self:emit(OpCodes.br, out)
  end
  if type(exp2) ~= "number" and exp2.tag ~= "number" then
    self:mark_label(very_slow_track)
    self:emit(OpCodes.call, arith_method_slow[op])
    self:store_local(retval)
    self:emit(OpCodes.pop)
  end
  self:mark_label(out)
  self:load_local(retval)
  self:release_temp(retval)
end

function _M:rel(op, exp1, exp2)
  local load_true = self:define_label()
  local slow_track = self:define_label()
  local type_mismatch = self:define_label()
  local out = self:define_label()
  if type(exp1) == "number" then
    self:emit(OpCodes.ldc_r8, exp1)
  elseif exp1.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp1.val)
  else
    self.compiler:compile(exp1)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.ldfld, luavalue_ref)
    self:emit(OpCodes.brtrue, slow_track)
    self:emit(OpCodes.ldfld, luavalue_val)
  end
  if type(exp2) == "number" then
    self:emit(OpCodes.ldc_r8, exp2)
  elseif exp2.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp2.val)
  else
    self.compiler:compile(exp2)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.ldfld, luavalue_ref)
    self:emit(OpCodes.brtrue, type_mismatch)
    self:emit(OpCodes.ldfld, luavalue_val)
  end
  self:emit(op, load_true)
  self:load_false()
  self:emit(OpCodes.br, out)
  self:mark_label(load_true)
  self:load_true()
  self:emit(OpCodes.br, out)
  if type(exp1) ~= "number" and exp1.tag ~= "number" then
    self:mark_label(slow_track)
    self.compiler:compile(exp2)
    self:emit(OpCodes.call, rel_method[op])
    self:emit(OpCodes.br, out)
  end
  if type(exp2) ~= "number" and exp2.tag ~= "number"  then
    self:mark_label(type_mismatch)
    if op == "beq" then
      self:load_false()
    else
      self:error("type mismatch in comparison")
    end
    self:emit(OpCodes.br, out)
  end
  self:mark_label(out)
end

function _M:logical_and(exp1, exp2)
  local out = self:define_label()
  local load_false = self:define_label()
  self.compiler:compile(exp1)
  self:jump_if_false(load_false)
  self.compiler:compile(exp2)
  self:emit(OpCodes.br, out)
  self:mark_label(load_false)
  self:load_false()
  self:mark_label(out)
end

function _M:logical_or(exp1, exp2)
  local out = self:define_label()
  local try_exp2 = self:define_label()
  self.compiler:compile(exp1)
  self:emit(OpCodes.dup)
  self:jump_if_false(try_exp2)
  self:emit(OpCodes.br, out)
  self:mark_label(try_exp2)
  self:emit(OpCodes.pop)
  self.compiler:compile(exp2)
  self:mark_label(out)
end

function _M:logical_not(exp)
  local out = self:define_label()
  local load_true = self:define_label()
  self:jump_if_false(load_true)
  self:load_false()
  self:emit(OpCodes.br, out)
  self:mark_label(load_true)
  self:load_true()
  self:mark_label(out)
end

function _M:len(exp)
  self.compiler:compile(exp)
  self:emit(OpCodes.call, len_method)
end

function _M:add(exp1, exp2)
  self:arith(OpCodes.add, exp1, exp2)
end

function _M:argslist(list, return_array)
  if #list > max_args then return_array = true end
  local temp = self:get_temp(luavalue_array_type)
  local last = list[#list]
  if last and last.tag == "call" then
    if #list == 1 then
      self.compiler:compile(last, "array")
      return nil
    end
    return_array = true
    list[#list] = nil
    local size = self:get_temp(int4_type)
    self.compiler:compile(last, "array")
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
      self:emit(OpCodes.stelem, luavalue_type)
    end
    self:load_local(temp)
    return nil
  else
    for i = 1, #list do
      self.compiler:compile(list[i])
    end
    return #list
  end
  self:release_temp(temp)
end

function _M:explist(list, adjust_n)
  local i = 1
  while i < #list and i <= adjust_n do
    self.compiler:compile(list[i])
    i = i + 1
  end
  if i <= adjust_n then
    if list[i].tag == "call" then
      self.compiler:compile(list[i], adjust_n - i + 1)
    else
      self.compiler:compile(list[i])
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
  self:emit(OpCodes.call, settable_method)
end

function _M:gettable()
  self:emit(OpCodes.call, gettable_method)
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

function _M:call(nargs, nres)
  if not nargs then
    self:emit(OpCodes.call, call_with_array)
  else
    self:emit(OpCodes.call, call_with[nargs])
  end
  if not nres then
    self:emit(OpCodes.ldc_i4_0)
    self:emit(OpCodes.ldelem, luavalue_type)
  elseif nres == 0 then
    self:emit(OpCodes.pop)
  elseif type(nres) == "number" then
    local temp = self:get_temp(luavalue_array_type)
    local size = self:get_temp(int4_type)
    self:store_local(temp)
    self:load_local(temp)
    self:emit(OpCodes.ldlen)
    self:store_local(size)
    for i = 0, nres - 1 do
      local load_nil = self:define_label()
      local next = self:define_label()
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
  end
end

function _M:emit(opcode, ...)
  self.ops[#self.ops + 1] = { opcode, ... }
end

function _M:new_func(func)
  for upval, _ in pairs(func.upvals) do
    if upval.func == self.compiler.current_func then
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
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.ldarg, arg)
      self:emit(OpCodes.stelem, luavalue_type)
      arg.isarg = false
    end
  end
end

function _M:new_table()
  local retval = self:get_temp()  
  self:load_local(retval)
  self:emit(OpCodes.ldflda, luavalue_ref)
  self:emit(OpCodes.newobj, table_cons)
  self:emit(OpCodes.stind)
  self:load_local(retval)
  self:release_temp(retval)
end

function _M:constructor()
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.call, closure_cons)
  local func = self.compiler.current_func
  local args = {}
  for upval, _ in pairs(func.upvals) do
    args[#args + 1] = "Lua.Value[] " .. upval.name
    self:emit(OpCodes.ldarg_0)
    self:emit(OpCodes.ldarg, #args)
    self:emit(OpCodes.stfld, upval)
  end
  self:emit(OpCodes.ret)
  func.ctor_name = ".ctor(" .. table.concat(args, ", ") .. ")"
end

function _M:class_constructor()
  local func = self.compiler.current_func
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
      self:emit(OpCodes.newobj, string_cons);
      self:emit(OpCodes.stfld, luavalue_ref)
    end
  end
  self:emit(OpCodes.ldsflda, self.compiler:get_literal())
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.stfld, luavalue_ref)
  self:emit(OpCodes.ret)
end

function _M:invoke(nargs, fargs)
  if nargs == "array" then
    local size = self:get_temp()
    self:emit(OpCodes.ldarg_1)
    self:emit(OpCodes.ldlen)
    self:store_local(size)
    self:emit(OpCodes.ldarg_0)
    for i = 1, fargs do
      local lnil = self:define_label()
      local next = self:define_label()
      self:emit(OpCodes.ldc_i4, i)
      self:load_local(size)
      self:emit(OpCodes.bgt, lnil)
      self:emit(OpCodes.ldarg_1)
      self:emit(OpCodes.ldc_i4, i - 1)
      self:emit(OpCodes.ldelem)
      self:emit(OpCodes.br, next)
      self:mark_label(lnil)
      self:load_nil()
      self:mark_label(next)
    end
  else
    self:emit(OpCodes.ldarg_0)
    for i = 1, fargs do
      if i > nargs then
	self:load_nil()
      else
	self:emit(OpCodes.ldarg, i)
      end
    end
  end
  self:emit(OpCodes.call, call_with[fargs])
  self:emit(OpCodes.ret)
end
