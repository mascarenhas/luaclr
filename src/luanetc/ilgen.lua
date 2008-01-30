local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

SYMBOL_SIZE = 30

luavalue_type = "object"
luavalue_array_type = "object[]"
luavalue_ref = "object [lua]Lua.UpValue::Ref"
luavalue_ref_type = "class [lua]Lua.UpValue"
luavalue_ref_cons = "instance void [lua]Lua.UpValue::.ctor()"
luaref_type = "class [lua]Lua.Reference"
int4_type = "int32"
double_type = "float64"
array_copy = "void [mscorlib]System.Array::Copy(class [mscorlib]System.Array,int32,class [mscorlib]System.Array,int32,int32)"
env_field = "class [lua]Lua.Reference [lua]Lua.Closure::Env"
closure_cons = "instance void [lua]Lua.Closure::.ctor()"
symbol_intern = "class [lua]Lua.Symbol [lua]Lua.Symbol::Intern(string)"
string_cons = "instance void [lua]Lua.String::.ctor()"
table_cons = "instance void [lua]Lua.Table::.ctor()"

nil_singleton = "class [lua]Lua.Reference [lua]Lua.Nil::Instance"
false_singleton = "class [lua]Lua.Reference [lua]Lua.False::Instance"
true_singleton = "class [lua]Lua.Reference [lua]Lua.True::Instance"

gettable_method = "instance object [lua]Lua.Reference::get_Item(object)"
settable_method = "instance void [lua]Lua.Reference::set_Item(object, object)"
neg_method = "instance object [lua]Lua.Reference::Negate()"
len_method = "instance object [lua]Lua.Reference::Length()"
concat_method = "object [lua]Lua.Reference::Concat(object, object)"
arith_method = {
  add = "instance object [lua]Lua.Reference::Add(object)",
  sub = "instance object [lua]Lua.Reference::Subtract(object)",
  mul = "instance object [lua]Lua.Reference::Multiply(object)",
  div = "instance object [lua]Lua.Reference::Divide(object)",
  rem = "instance object [lua]Lua.Reference::Mod(object)",
  exp = "instance object [lua]Lua.Reference::Pow(object)"
}
arith_method_slow = {
  add = "instance object [lua]Lua.Reference::Add(float64)",
  sub = "instance object [lua]Lua.Reference::Subtract(float64)",
  mul = "instance object [lua]Lua.Reference::Multiply(float64)",
  div = "instance object [lua]Lua.Reference::Divide(float64)",
  rem = "instance object [lua]Lua.Reference::Mod(float64)",
  exp = "instance object [lua]Lua.Reference::Pow(float64)"
}
rel_method = {
  beq = "instance bool [lua]Lua.Reference::Equals(class [lua]Lua.Reference)",
  bne = "instance bool [lua]Lua.Reference::NotEquals(class [lua]Lua.Reference)",
  blt = "instance bool [lua]Lua.Reference::LessThan(class [lua]Lua.Reference)",
  bgt = "instance bool [lua]Lua.Reference::GreaterThan(class [lua]Lua.Reference)",
  ble = "instance bool [lua]Lua.Reference::LessThanOrEquals(class [lua]Lua.Reference)",
  bge = "instance bool [lua]Lua.Reference::GreaterThanOrEquals(class [lua]Lua.Reference)"
}

max_args = 7
local function call_with(nargs, nres)
  local ret_type, invoke_name
  if not nres or nres == 0 or nres == 1 then
    ret_type = "object"
    invoke_name = "InvokeS"
  else
    ret_type = "object[]"
    invoke_name = "InvokeM"
  end
  if not nargs then
    return "instance " .. ret_type .. " [lua]Lua.Reference::" .. invoke_name .. "(object[])"
  else
    local args = {}
    for j = 1, nargs do args[#args + 1] = "object" end
    return "instance " .. ret_type .. " [lua]Lua.Reference::" .. invoke_name .. 
      "(" .. table.concat(args, ", ") .. ")"
  end
end

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
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.beq, to)
  self:load_local(temp)
  self:emit(OpCodes.ldsfld, false_singleton)
  self:emit(OpCodes.beq, to)
  self:release_temp(temp)
end

function _M:jump_if_nil(to)
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
  self:mark_label(self.loops[#self.loops])
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
      self:load_local(localvar.temp)
      self:emit(OpCodes.stfld, luavalue_ref)
    else
      local temp = self:get_temp()
      self:store_local(temp)
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, localvar)
      self:load_local(temp)
      self:emit(OpCodes.stfld, luavalue_ref)
      self:release_temp(temp)
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
      self:emit(OpCodes.ldfld, luavalue_ref)
    else
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, localvar)
      self:emit(OpCodes.ldfld, luavalue_ref)
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
  local slow_track = self:define_label()
  local out = self:define_label()
  self.compiler:compile(exp)
  self:emit(OpCodes.dup)
  self:emit(OpCodes.isinst, double_type)
  self:emit(OpCodes.brfalse, slow_track)
  self:emit(OpCodes.unbox_any, double_type)
  self:emit(OpCodes.neg)
  self:emit(OpCodes.box, double_type)
  self:emit(OpCodes.br, out)
  self:mark_label(slow_track)
  self:emit(OpCodes.castclass, luaref_type)
  self:emit(OpCodes.callvirt, neg_method)
  self:mark_label(out)
end

function _M:arith(op, exp1, exp2)
  local slow_track = self:define_label()
  local very_slow_track = self:define_label()
  local out = self:define_label()
  if type(exp1) == "number" then
    self:emit(OpCodes.ldc_r8, exp1)
  elseif exp1.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp1.val)
  else
    self.compiler:compile(exp1)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.isinst, double_type)
    self:emit(OpCodes.brfalse, slow_track)
    self:emit(OpCodes.unbox_any, double_type)
  end
  if type(exp2) == "number" then
    self:emit(OpCodes.ldc_r8, exp2)
  elseif exp2.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp2.val)
  else
    self.compiler:compile(exp2)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.isinst, double_type)
    self:emit(OpCodes.brfalse, very_slow_track)
    self:emit(OpCodes.unbox_any, double_type)
  end
  self:emit(op)
  self:emit(OpCodes.box, double_type)
  self:emit(OpCodes.br, out)
  if type(exp1) ~= "number" and exp1.tag ~= "number" then
    self:mark_label(slow_track)
    self:emit(OpCodes.castclass, luaref_type)
    self.compiler:compile(exp2)
    self:emit(OpCodes.callvirt, arith_method[op])
    self:emit(OpCodes.br, out)
  end
  if type(exp2) ~= "number" and exp2.tag ~= "number" then
    self:mark_label(very_slow_track)
    local temp1 = self:get_temp()
    local temp2 = self:get_temp(double_type)
    self:emit(OpCodes.stloc, temp1)
    self:emit(OpCodes.stloc, temp2)
    self:emit(OpCodes.ldloc, temp1)
    self:emit(OpCodes.castclass, luaref_type)
    self:emit(OpCodes.ldloc, temp2)    
    self:emit(OpCodes.callvirt, arith_method_slow[op])
    self:release_temp(temp2)
    self:release_temp(temp1)
  end
  self:mark_label(out)
end

function _M:rel(op, exp1, exp2, label)
  local load_true = self:define_label()
  local slow_track = self:define_label()
  local type_mismatch_number = self:define_label()
  local type_mismatch_ref = self:define_label()
  local out = self:define_label()
  if type(exp1) == "number" then
    self:emit(OpCodes.ldc_r8, exp1)
  elseif exp1.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp1.val)
  else
    self.compiler:compile(exp1)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.isinst, double_type)
    self:emit(OpCodes.brfalse, slow_track)
    self:emit(OpCodes.unbox_any, double_type)
  end
  if type(exp2) == "number" then
    self:emit(OpCodes.ldc_r8, exp2)
  elseif exp2.tag == "number" then
    self:emit(OpCodes.ldc_r8, exp2.val)
  else
    self.compiler:compile(exp2)
    self:emit(OpCodes.dup)
    self:emit(OpCodes.isinst, double_type)
    self:emit(OpCodes.brfalse, type_mismatch_number)
    self:emit(OpCodes.unbox_any, double_type)
  end
  if label then
    self:emit(op, label)
  else
    self:emit(op, load_true)
    self:load_false()
  end
  self:emit(OpCodes.br, out)
  if not label then
    self:mark_label(load_true)
    self:load_true()
    self:emit(OpCodes.br, out)
  end
  if type(exp1) ~= "number" and exp1.tag ~= "number" then
    self:mark_label(slow_track)
    if type(exp2) ~= "number" and exp2.tag ~="number" then
        self:emit(OpCodes.castclass, luaref_type)
	self.compiler:compile(exp2)
	if type(exp2) ~= "string" and exp2.tag ~= "string" then
    	  self:emit(OpCodes.dup)
	  self:emit(OpCodes.isinst, luaref_type)
          self:emit(OpCodes.brfalse, type_mismatch_ref)
	end
        self:emit(OpCodes.castclass, luaref_type)
        self:emit(OpCodes.callvirt, rel_method[op])
        if label then
          self:emit(OpCodes.brtrue, label)
        else
          self:emit(OpCodes.brtrue, load_true)
          self:load_false()
        end
        self:emit(OpCodes.br, out)
	if type(exp2) ~= "string" and exp2.tag ~= "string" then
          self:mark_label(type_mismatch_ref)
          self:emit(OpCodes.pop)
          self:emit(OpCodes.pop)
          if op == "beq" then
            if not label then self:load_false() end
	    self:emit(OpCodes.br, out)
          else
            self:error("type mismatch in comparison")
          end
        end
    else
      self:emit(OpCodes.pop)
      if op == "beq" then
        if not label then self:load_false() end
	self:emit(OpCodes.br, out)
      else
        self:error("type mismatch in comparison")
      end
    end
  end
  if type(exp2) ~= "number" and exp2.tag ~= "number"  then
    self:mark_label(type_mismatch_number)
    self:emit(OpCodes.pop)
    self:emit(OpCodes.pop)
    if op == "beq" then
      if not label then self:load_false() end
    else
      self:error("type mismatch in comparison")
    end
  end
  self:mark_label(out)
end

function _M:concat(exp1, exp2)
  self:emit(OpCodes.call, concat_method)
end

function _M:error(err)
  self:emit(OpCodes.ldstr, err)
  self:emit(OpCodes.newobj, "instance void [mscorlib]System.Exception::.ctor(string)")
  self:emit(OpCodes.throw)
--  self:load_false()
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
  self.compiler:compile(exp)
  self:jump_if_false(load_true)
  self:load_false()
  self:emit(OpCodes.br, out)
  self:mark_label(load_true)
  self:load_true()
  self:mark_label(out)
end

function _M:len(exp)
  self.compiler:compile(exp)
  self:emit(OpCodes.castclass, luaref_type)
  self:emit(OpCodes.callvirt, len_method)
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
    self:emit(OpCodes.ldc_i4_0)
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
    if list[i] and list[i].tag == "call" then
      self.compiler:compile(list[i], adjust_n - i + 1)
    else
      self.compiler:compile(list[i])
      for i = (i + 1), adjust_n do
	self:load_nil()
      end
    end
    i = i + 1    
  end
  while i <= #list do
    self.compiler:compile(list[i])
    self:emit(OpCodes.pop)
    i = i + 1
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
  self:emit(OpCodes.callvirt, settable_method)
end

function _M:gettable()
  self:emit(OpCodes.callvirt, gettable_method)
end

function _M:load_string(name)
  self:emit(OpCodes.ldsfld, self.compiler:get_literal(name))
end

function _M:load_number(n)
  self:emit(OpCodes.ldc_r8, n)
  self:emit(OpCodes.box, double_type)
end

function _M:load_nil()
  self:emit(OpCodes.ldsfld, nil_singleton)
end

function _M:load_true()
  self:emit(OpCodes.ldsfld, true_singleton)
end

function _M:load_false()
  self:emit(OpCodes.ldsfld, false_singleton)
end

function _M:call(nargs, nres, is_tail)
  local call_op = (is_tail and OpCodes.tail_callvirt) or OpCodes.callvirt
  self:emit(call_op, call_with(nargs, nres))
  if nres == 0 then
    self:emit(OpCodes.pop)
  elseif type(nres) == "number" and nres > 1 then
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
      self:load_nil()
      self:mark_label(next)
    end
    self:release_temp(temp)
    self:release_temp(size)
  end
end

function _M:emit(opcode, ...)
  if opcode == OpCodes.castclass then
    self:emit(OpCodes.unbox_any, ...)
  else
    self.ops[#self.ops + 1] = { opcode, ... }
  end
end

function _M:new_func(func)
  local temp = self:get_temp()
  for upval, _ in pairs(func.upvals) do
    if upval.func == self.compiler.current_func then
      self:emit(OpCodes.ldloc, upval)
    else
      self:emit(OpCodes.ldarg_0)
      self:emit(OpCodes.ldfld, upval)
    end
  end
  self:emit(OpCodes.newobj, "instance void " .. func.clr_type .. "::" .. func.ctor_name)
  self:emit(OpCodes.dup)
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.ldfld, env_field)
  self:emit(OpCodes.stfld, env_field)
  self:release_temp(temp)
end

function _M:prologue()
  local func = self.compiler.current_func
  local args, locals = func.args, func.locals
  for _, var in ipairs(locals) do
    if var.isupval then
      self:emit(OpCodes.newobj, luavalue_ref_cons)
      self:emit(OpCodes.stloc, var)
      var.temp = self:get_temp()
    end
  end
  for _, arg in ipairs(args) do
    if arg.isupval then
      locals[#locals + 1] = arg
      self:emit(OpCodes.newobj, luavalue_ref_cons)
      self:emit(OpCodes.stloc, arg)
      self:emit(OpCodes.ldloc, arg)
      self:emit(OpCodes.ldarg, arg)
      self:emit(OpCodes.stfld, luavalue_ref)
      arg.isarg = false
    end
  end
end

function _M:new_table()
  self:emit(OpCodes.newobj, table_cons)
end

function _M:constructor()
  self:emit(OpCodes.ldarg_0)
  self:emit(OpCodes.call, closure_cons)
  local func = self.compiler.current_func
  local args = {}
  for upval, _ in pairs(func.upvals) do
    args[#args + 1] = "class [lua]Lua.UpValue " .. upval.name
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
    if type(val) == "boolean" then
      if val then
	self:emit(OpCodes.ldsfld, true_singleton)
      else
	self:emit(OpCodes.ldsfld, false_singleton)
      end
    elseif type(val) == "number" then
      self:emit(OpCodes.ldc_r8, val)
      self:emit(OpCodes.box, double_type)
    elseif string.len(val) > SYMBOL_SIZE then
      self:emit(OpCodes.ldstr, val)
      self:emit(OpCodes.call, string_cons);
    else
      self:emit(OpCodes.ldstr, val)
      self:emit(OpCodes.call, symbol_intern);
    end
    self:emit(OpCodes.stsfld, self.compiler:get_literal(val))
  end
  self:emit(OpCodes.ldsfld, nil_singleton)
  self:emit(OpCodes.stsfld, self.compiler:get_literal())
  self:emit(OpCodes.ret)
end

function _M:invoke(func_type, nargs, fargs, ret_type, invoke_name, isvararg)
  if nargs == "array" then
    self:emit(OpCodes.ldarg_1)
    self:emit(OpCodes.ldlen)
    self:emit(OpCodes.stloc_0)
    self:emit(OpCodes.ldarg_0)
    for i = 1, fargs do
      local lnil = self:define_label()
      local next = self:define_label()
      self:emit(OpCodes.ldc_i4, i)
      self:emit(OpCodes.ldloc_0)
      self:emit(OpCodes.bgt, lnil)
      self:emit(OpCodes.ldarg_1)
      self:emit(OpCodes.ldc_i4, i - 1)
      self:emit(OpCodes.ldelem, luavalue_type)
      self:emit(OpCodes.br, next)
      self:mark_label(lnil)
      self:load_nil()
      self:mark_label(next)
    end
    if isvararg then
      local has_varargs = self:define_label()
      local call = self:define_label()
      self:emit(OpCodes.ldloc_0)
      self:emit(OpCodes.ldc_i4, fargs)
      self:emit(OpCodes.sub)
      self:emit(OpCodes.stloc_0)
      self:emit(OpCodes.ldloc_0)
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.bgt, has_varargs)
      self:emit(OpCodes.ldnull)
      self:emit(OpCodes.br, call)
      self:mark_label(has_varargs)
      self:emit(OpCodes.ldarg_1)
      self:emit(OpCodes.ldc_i4, fargs)
      self:emit(OpCodes.ldloc_0)
      self:emit(OpCodes.newarr, luavalue_type)
      self:emit(OpCodes.dup)
      self:emit(OpCodes.starg_1)
      self:emit(OpCodes.ldc_i4_0)
      self:emit(OpCodes.ldloc_0)
      self:emit(OpCodes.call, array_copy)
      self:emit(OpCodes.ldarg_1)
      self:mark_label(call)
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
    if isvararg then
      if nargs > fargs then
	local nvarargs = nargs - fargs
	self:emit(OpCodes.ldc_i4, nvarargs)
	self:emit(OpCodes.newarr, luavalue_type)
	for i = fargs, nargs - 1 do
	  self:emit(OpCodes.dup)
	  self:emit(OpCodes.ldarg, i)
	  self:emit(OpCodes.ldc_i4, i - fargs)
	  self:emit(OpCodes.stelem, luavalue_type)
	end
      else
	self:emit(OpCodes.ldnull)
      end
    end
  end
  local args = {}
  local vararg = ""
  if isvararg then
    vararg = ", object[]"
  end
  for i = 1, fargs do args[#args + 1] = "object" end
  local func_invoke = "instance " .. ret_type .. " " .. 
    func_type .. "::" .. invoke_name .. "(" .. table.concat(args, ", ") .. vararg .. ")"
  self:emit(OpCodes.call, func_invoke)
  self:emit(OpCodes.ret)
end
