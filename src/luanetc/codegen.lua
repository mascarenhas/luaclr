local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

visitor = {}

function visitor.block(compiler, block)
  for _, stat in ipairs(block) do
    compiler:compile(stat, 0)
  end
end

function visitor.chunk(compiler, chunk)
  compiler:start_function(chunk)
  compiler:compile(chunk.block)
  compiler.ilgen:load_nil()
  compiler.ilgen:emit(OpCodes.ret)
  compiler:end_function()
end

visitor["while"] = function (compiler, nwhile)
  local test = compiler.ilgen:define_label()
  local out = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(test)
  compiler:compile(nwhile.exp)
  if nwhile.exp.type ~= "number" then
    compiler.ilgen:jump_if_false(out)
  end
  compiler:compile(nwhile.block)
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:end_loop()
end

visitor["repeat"] = function (compiler, nrepeat)
  local top = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(top)
  compiler:compile(nrepeat.block)
  compiler:compile(nrepeat.exp)
  if nwhile.exp.type ~= "number" then
    compiler.ilgen:jump_if_false(top)
  end
  compiler.ilgen:end_loop()
end

visitor["if"] = function (compiler, nif)
  local out = compiler.ilgen:define_label()
  local lelse = compiler.ilgen:define_label()
  compiler:compile(nif.cond)
  if nif.cond.type ~= "number" then
    compiler.ilgen:jump_if_false(lelse)
  end
  compiler:compile(nif.block)
  compiler.ilgen:emit(OpCodes.br, out)
  compiler.ilgen:mark_label(lelse)
  if nif.block_else then
    compiler:compile(nif.block_else)
  end
  compiler.ilgen:mark_label(out)
end

visitor["do"] = function (compiler, ndo)
  compiler:compile(ndo.block)
end

function visitor.nfor(compiler, nfor)
  local test = compiler.ilgen:define_label()
  local loop = compiler.ilgen:define_label()
  compiler:compile(nfor.start)
  if nfor.start.type == "number" and nfor.var.ref.type ~= "number" then
    compiler.ilgen:box_number()
  end
  compiler.ilgen:store_local(nfor.var.ref)
  local temp_finish = compiler.ilgen:get_temp(compiler.ilgen.double_type)
  compiler:compile(nfor.finish)
  print("// Type: " .. nfor.finish.type .. "\n")
  if nfor.finish.type ~= "number" then
    compiler.ilgen:unbox_number()
  end
  compiler.ilgen:store_local(temp_finish)
  local temp_step = compiler.ilgen:get_temp(compiler.ilgen.double_type)
  if nfor.step then
    compiler:compile(nfor.step)
    if nfor.finish.type ~= "number" then
      compiler.ilgen:unbox_number()
    end
    compiler.ilgen:store_local(temp_step)
  end
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(loop)
  compiler.ilgen:start_loop()
  compiler:compile(nfor.block)
  if nfor.step then
    compiler.ilgen:load_local(nfor.var.ref)
    if nfor.var.ref.type ~= "number" then
      compiler.ilgen:unbox_number()
    end
    compiler.ilgen:load_local(temp_step)
    compiler.ilgen:emit(OpCodes.add)
    if nfor.var.ref.type ~= "number" then
      compiler.ilgen:box_number()
    end
    compiler.ilgen:store_local(nfor.var.ref)
  else
    compiler.ilgen:load_local(nfor.var.ref)
    if nfor.var.ref.type ~= "number" then
      compiler.ilgen:unbox_number()
    end
    compiler.ilgen:emit(OpCodes.ldc_r8, 1)
    compiler.ilgen:emit(OpCodes.add)
    if nfor.var.ref.type ~= "number" then
      compiler.ilgen:box_number()
    end
    compiler.ilgen:store_local(nfor.var.ref)
  end
  compiler.ilgen:mark_label(test)
  compiler.ilgen:load_local(nfor.var.ref)
  if nfor.var.ref.type ~= "number" then
    compiler.ilgen:unbox_number()
  end
  compiler.ilgen:load_local(temp_finish)
  compiler.ilgen:emit(OpCodes.ble, loop)
  compiler.ilgen:end_loop()
  compiler.ilgen:release_temp(temp_finish)
  compiler.ilgen:release_temp(temp_step)
end

function visitor.gfor(compiler, gfor)
  local temp_control = gfor.vars[1].ref
  local temp_state = compiler.ilgen:get_temp()
  local temp_iter = compiler.ilgen:get_temp()
  compiler.ilgen:explist(gfor.exps, 3)
  compiler.ilgen:store_local(temp_control)
  compiler.ilgen:store_local(temp_state)
  compiler.ilgen:store_local(temp_iter)
  local test = compiler.ilgen:define_label()
  compiler.ilgen:mark_label(test)
  compiler.ilgen:start_loop()
  compiler.ilgen:load_local(temp_iter)
  compiler.ilgen:emit(OpCodes.castclass, compiler.ilgen.luaref_type)
  compiler.ilgen:load_local(temp_state)
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:call(2, #gfor.vars)
  for i = #gfor.vars, 1, -1 do
    compiler.ilgen:store_local(gfor.vars[i].ref)
  end
  local out = compiler.ilgen:define_label()
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:jump_if_nil(out)
  compiler:compile(gfor.block)
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:end_loop()
  compiler.ilgen:release_temp(temp_iter)
  compiler.ilgen:release_temp(temp_state)
end

visitor["function"] = function (compiler, nfunction)
  if not nfunction.compiled then
    compiler:start_function(nfunction)
    compiler:compile(nfunction.block)
    compiler.ilgen:load_nil()
    compiler.ilgen:emit(OpCodes.ret)
    compiler:end_function()
  end
  compiler.ilgen:new_func(nfunction)
end

visitor["local"] = function (compiler, nlocal)
  if nlocal.exps then
    compiler.ilgen:explist(nlocal.exps, #nlocal.names)
    for i = #nlocal.names, 1, -1 do
      if nlocal.exps[i] and nlocal.exps[i].type == "number" and nlocal.names[i].ref.type ~= "number" then
	compiler.ilgen:box_number()
      end
      compiler.ilgen:store_local(nlocal.names[i].ref)
    end
  else
    for i = #nlocal.names, 1, -1 do
      compiler.ilgen:load_nil()
      compiler.ilgen:store_local(nlocal.names[i].ref)
    end
  end
end

function visitor.assign(compiler, assign)
  compiler.ilgen:explist(assign.exps, #assign.vars)
  for i = #assign.vars, 1, -1 do
    if assign.exps[i] and assign.exps[i].type == "number" and assign.vars[i].ref.type ~= "number" then
      compiler.ilgen:box_number()
    end
    compiler:compile(assign.vars[i])
  end
end

visitor["break"] = function (compiler, nbreak)
  compiler.ilgen:break_loop()
end

visitor["return"] = function (compiler, nreturn)
  if #nreturn.exps == 1 and nreturn.exps[1].tag == "call" then -- tail call
    if compiler.current_func.ret_type == "multi" then
      compiler:compile(nreturn.exps[1], "array", true)
    else
      compiler:compile(nreturn.exps[1], 1, true)
    end
  elseif compiler.current_func.ret_type == "multi" then
    compiler.ilgen:argslist(nreturn.exps, true)
  elseif compiler.current_func.ret_type == "single" then
    if #nreturn.exps > 0 then
      compiler:compile(nreturn.exps[1])
      if nreturn.exps[1].type == "number" then
	compiler.ilgen:box_number()
      end
    else
      compiler.ilgen:load_nil()
    end
    for i = 2, #nreturn.exps do
      compiler:compile(nreturn.exps[i])
      compiler.ilgen:emit(OpCodes.pop)
    end
  else
    error("return type not provided")
  end
  compiler.ilgen:emit(OpCodes.ret)
end

function visitor.var(compiler, var)
  if var.ref.tag == "name" then
    if var.ref.ref then
      compiler.ilgen:store_local(var.ref.ref)
    else
      compiler.ilgen:store_global(var.ref.val)
    end
  elseif var.ref.tag == "index" then
    local val = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(val)
    compiler:compile(var.ref.table)
    compiler.ilgen:emit(OpCodes.castclass, compiler.ilgen.luaref_type)
    compiler:compile(var.ref.index)
    compiler.ilgen:load_local(val)
    if var.ref.index.type == "number" then
      compiler.ilgen:settable_number()
    elseif var.ref.index.type == "string" then
      compiler.ilgen:settable_symbol()
    else
      compiler.ilgen:settable()
    end
    compiler.ilgen:release_temp(val)
  else
    error("invalid lvalue in code generation")
  end
end

function visitor.index(compiler, pexp)
  compiler:compile(pexp.table)
  compiler.ilgen:emit(OpCodes.castclass, compiler.ilgen.luaref_type)
  compiler:compile(pexp.index)
  if pexp.index.type == "number" then
    compiler.ilgen:gettable_number()
  elseif pexp.index.type == "string" then
    compiler.ilgen:gettable_symbol()
  else
    compiler.ilgen:gettable()
  end
end

function visitor.string(compiler, s)
  compiler.ilgen:load_string(s.val)
end

function visitor.number(compiler, n)
  compiler.ilgen:load_number(n.val)
end

function visitor.constructor(compiler, cons)
  compiler.ilgen:new_table()
  local i, last = 1, #cons.fields
  for i_field, field in ipairs(cons.fields) do
    if field.tag == "namefield" or field.tag == "indexfield" then
      compiler:compile(field)
    else
      if i_field == last then
	-- TODO: last call!
	compiler.ilgen:emit(OpCodes.dup)
	compiler.ilgen:load_number(i)
	compiler:compile(field, 1) -- replace with array 
	if field.type == "number" then
	  compiler.ilgen:box_number()
	end
	compiler.ilgen:settable_number()
      else
	compiler.ilgen:emit(OpCodes.dup)
	compiler.ilgen:load_number(i)
	compiler:compile(field, 1)
	if field.type == "number" then
	  compiler.ilgen:box_number()
	end
	compiler.ilgen:settable_number()
      end
      i = i + 1
    end
  end
end

function visitor.namefield(compiler, namefield)
  compiler.ilgen:emit(OpCodes.dup)
  compiler.ilgen:load_string(namefield.name)
  compiler:compile(namefield.exp, 1)
  if namefield.exp.type == "number" then
    compiler.ilgen:box_number()
  end
  compiler.ilgen:settable_symbol()
end

function visitor.indexfield(compiler, indexfield)
  compiler.ilgen:emit(OpCodes.dup)
  compiler:compile(indexfield.name, 1)
  compiler:compile(indexfield.exp, 1)
  if indexfield.exp.type == "number" then
    compiler.ilgen:box_number()
  end
  compiler.ilgen:settable()
end

function visitor.name(compiler, name)
  if name.ref then
    compiler.ilgen:load_local(name.ref)
  else
    compiler.ilgen:load_global(name.val)
  end
end

function visitor.binop(compiler, binop)
  local arith_ops = { ["+"] = "add", ["-"] = "sub", ["/"] = "div",
    ["*"] = "mul", ["%"] = "rem", ["^"] = "exp" }
  local rel_ops = { ["=="] = "beq", ["~="] = "bne", ["<"] = "blt",
    [">"] = "bgt", ["<="] = "ble", [">="] = "bge" }
  if arith_ops[binop.op] then
    compiler.ilgen:arith(arith_ops[binop.op], binop.left, binop.right, binop.type)
  elseif rel_ops[binop.op] then
    compiler.ilgen:rel(rel_ops[binop.op], binop.left, binop.right)
  elseif binop.op == "and" or binop.op == "or" then
    compiler.ilgen["logical_" .. binop.op](compiler.ilgen, 
					   binop.left, binop.right)
  elseif binop.op == ".." then
    compiler:compile(binop.left, 1)
    if binop.left.type == "number" then
      compiler.ilgen:box_number()
    end
    compiler:compile(binop.right, 1)
    if binop.right.type == "number" then
      compiler.ilgen:box_number()
    end
    compiler.ilgen:concat()
  else
    error("invalid binary operator: '" .. binop.op .. "'")
  end
end

function visitor.unop(compiler, unop)
  if unop.op == "-" then
    compiler.ilgen:neg(unop.operand)
  elseif unop.op == "#" then
    compiler.ilgen:len(unop.operand)
  elseif unop.op == "not" then
    compiler.ilgen:logical_not(unop.operand)
  else
    error("invalid unary operator")
  end
end

function visitor.call(compiler, call, nres, is_tail)
  local self_arg = compiler.ilgen:get_temp(compiler.ilgen.luaref_type)
  compiler:compile(call.func)
  compiler.ilgen:emit(OpCodes.castclass, compiler.ilgen.luaref_type)
  if call.method then
    compiler.ilgen:emit(OpCodes.dup)
    compiler.ilgen:store_local(self_arg)
    compiler.ilgen:load_string(call.method)
    compiler.ilgen:gettable_symbol()
    compiler.ilgen:emit(OpCodes.castclass, compiler.ilgen.luaref_type)
    table.insert(call.args, 1, { tag = "name", ref = self_arg })
  end
  local nargs = compiler.ilgen:argslist(call.args)
  compiler.ilgen:call(nargs, nres, is_tail)
  if call.method then
    table.remove(call.args, 1)
  end
  compiler.ilgen:release_temp(self_arg)
end

function compile(compiler, node, ...)
  if node and node.tag and visitor[node.tag] then 
    visitor[node.tag](compiler, node, ...)
  elseif node and node.tag == "nil" then
    compiler.ilgen:load_nil()
  elseif node and node.tag == "true" then
    compiler.ilgen:load_true()
  elseif node and node.tag == "false" then
    compiler.ilgen:load_false()
  elseif type(node) == "table" and (not node.tag) then
    visitor.block(compiler, node)
  else
    error("node " .. node .. " not supported by compiler yet")
  end
end
