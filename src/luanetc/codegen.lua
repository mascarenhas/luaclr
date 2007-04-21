local Compiler = require "cheese.luanetc.compiler"
local OpCodes = require "cheese.luanetc.opcodes"

module(..., package.seeall)

visitor = {}

function visitor.block(compiler, block)
  for _, stat in ipairs(block) do
    compiler:compile(stat)
  end
end

function visitor.chunk(compiler, chunk)
  compiler:start_function(chunk)
  compiler:compile(chunk.block)
  compiler:end_function()
end

visitor["while"] = function (compiler, nwhile)
  local test = compiler.ilgen:define_label()
  local out = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(test)
  compiler:compile(nwhile.exp)
  compiler.ilgen:jump_if_false(out)
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
  compiler.ilgen:jump_if_false(top)
  compiler.ilgen:end_loop()
end

visitor["if"] = function (compiler, nif)
  local out = compiler.ilgen:define_label()
  for _, clause in ipairs(nif.clauses) do
    local next = compiler.ilgen:define_label()
    compiler:compile(clause.cond)
    compiler.ilgen:jump_if_false(next)
    compiler:compile(clause.block)
    compiler:ilgen:emit(OpCodes.br, out)
    compiler.ilgen:mark_label(next)
  end
  if nif.block_else then
    compiler:compile(nif.block_else)
  end
  compiler.ilgen:mark_label(out)
end

visitor["do"] = function (st, ndo)
  compiler:compile(ndo.block)
end

function visitor.nfor(compiler, nfor)
  local test = compiler.ilgen:define_label()
  local out = compiler.ilgen:define_label()
  compiler:compile(nfor.start)
  compiler.ilgen:store_local(nfor.var.ref)
  local temp_finish = compiler.ilgen:get_temp()
  compiler:compile(nfor.finish)
  compiler.ilgen:store_local(temp_finish)
  local temp_step = compiler.ilgen:get_temp()
  if nfor.step then
    compiler:compile(nfor.step)
    compiler.ilgen:store_local(temp_step)
  end
  compiler.ilgen:start_loop()
  compiler.ilgen:mark_label(test)
  compiler.ilgen:jump_if_not_equal(function () 
  				     compiler.ilgen:load_local(nfor.var.ref)
			           end,
			           function ()
				     compiler.ilgen:load_local(temp_finish)
			           end, out)
  compiler:compile(nfor.block)
  if temp_step then
    compiler.ilgen:add(function ()
			 compiler.ilgen:load_local(nfor.var.ref)
		       end,
		       function ()
			 compiler.ilgen:load_local(temp_step)
		       end)
  else
    compiler.ilgen:add_number(function ()
			        compiler.ilgen:load_local(nfor.var.ref)
		              end, 1)
  end
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(out)
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
  local test = compile.ilgen:define_label()
  compile.ilgen:mark_label(test)
  compiler.ilgen:load_local(temp_iter)
  compiler.ilgen:load_local(temp_state)
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:call(#gfor.vars, 3)
  for i = #gfor.vars, 1, -1 do
    compiler.ilgen:store_local(gfor.vars[i].ref)
  end
  local out = compiler.ilgen:define_label()
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:jump_if_nil(out)
  compiler:compile(gfor.block)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:end_loop()
  compiler.ilgen:release_temp(temp_iter)
  compiler.ilgen:release_temp(temp_state)
end

visitor["function"] = function (compiler, nfunction)
  compiler:start_function(nfunction)
  compiler:compile(nfunction.block)
  local func = compiler:end_function()
  compiler.ilgen:new_func(func)
  if nfunction.islocal then
    compiler.ilgen:store_local(nfunction.name.ref)
  elseif nfunction.name then
    compiler:compile(nfunction.name)
  end
end

visitor["local"] = function (compiler, nlocal)
  compiler.ilgen:explist(nlocal.exps, #nlocal.names)
  for i = #nlocal.names, 1, -1 do
    compiler.ilgen:store_local(nlocal.names[i].ref)
  end
end

function visitor.assign(st, assign)
  compiler.ilgen:explist(assign.exps, #assign.vars)
  for i = #assign.vars, 1, -1 do
    compiler:compile(assign.vars[i])
  end
end

visitor["break"] = function (compiler, nbreak)
  compiler.ilgen:break_loop()
end

visitor["return"] = function (compiler, nreturn)
  self.ilgen:argslist(nreturn.exps, true)
  compiler.ilgen:emit(OpCodes.ret)
end

function visitor.var(var)
  if #var.indexes == 0 and var.prefix.ref then
    compiler.ilgen:store_local(var.prefix.ref)
  elseif #var.indexes == 0 then
    compiler.ilgen:store_global(var.prefix.val)
  else
    if var.prefix.ref then
      compiler.ilgen:load_local(var.prefix.ref)
    else
      compiler.ilgen:load_global(var.prefix.val)
    end
    for i = 1, (#var.indexes - 1) do
      if not var.indexes[i].tag then
	local nargs = compiler.ilgen:argslist(var.indexes[i])
      	compiler.ilgen:call(1, nargs)
      elseif var.indexes[i].tag == "method" then
	local self_arg = compiler.ilgen:get_temp()
	compiler.ilgen:emit(OpCodes.dup)
	compiler.ilgen:store_local(self_arg)
	compiler.ilgen:load_string(var.indexes[i].name)
	compiler.ilgen:gettable()
	table.insert(var.indexes[i].args, 1, { tag = "name", ref = self_arg })
	local nargs = compiler.ilgen:argslist(var.indexes[i].args)
	compiler.ilgen:call(1, nargs)
	table.remove(var.indexes[i].args, 1)
	compiler.ilgen:release_temp(self_arg)
      else
        compiler:compile(var.indexes[i])
        compiler.ilgen:gettable()
      end
    end
    local tab = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(tab)
    local val = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(val)
    compiler.ilgen:load_local(tab)
    compiler:compile(var.indexes[#var.indexes])
    compiler.ilgen:load_local(val)
    compiler.ilgen:settable()
    compiler.ilgen:release_temp(tab)
    compiler.ilgen:release_temp(val)
  end
end

function visitor.primaryexp(compiler, pexp)
  compiler:compile(pexp.prefix)
  for _, exp_index in ipairs(pexp.indexes) do
    if not exp_index.tag then
      local nargs = compile.ilgen:argslist(exp_index)
      compiler.ilgen:call(1, nargs)
    elseif exp_index.tag == "method" then
      local self_arg = compiler.ilgen:get_temp()
      compiler.ilgen:emit(OpCodes.dup)
      compiler.ilgen:store_local(self_arg)
      compiler.ilgen:load_string(exp_index.name)
      compiler.ilgen:gettable()
      table.insert(exp_index.args, 1, { tag = "name", ref = self_arg })
      local nargs = compile.ilgen:argslist(exp_index.args)
      compiler.ilgen:call(1, nargs)
      table.remove(exp_index.args, 1)
      compiler.ilgen:release_temp(self_arg)
    else
      compiler:compile(exp_index)
      compiler.ilgen:gettable()
    end
  end
end

function visitor.string(compiler, s)
  compiler.ilgen:load_string(s)
end

function visitor.number(compiler, n)
  compiler.ilgen:load_number(n)
end

function visitor.expindex(st, expindex)
  compiler:compile(expindex.exp)
end

function visitor.nameindex(compiler, nameindex)
  compiler.ilgen:load_string(nameindex.name)
end

function visitor.constructor(st, cons)
  for _, field in ipairs(cons.fields) do
    tie_refs(st, field)
  end
end

function visitor.namefield(st, namefield)
  tie_refs(st, namefield.exp)
end

function visitor.indexfield(st, indexfield)
  tie_refs(st, indexfield.name)
  tie_refs(st, indexfield.exp)
end

function visitor.funcname(compiler, funcname)
  if #funcname.indexes == 0 and funcname.var.ref then
    compiler.ilgen:store_local(funcname.var.ref)
  elseif #funcname.indexes == 0 then
    compiler.ilgen:store_global(funcname.var.val)
  else
    if funcname.var.ref then
      compiler.ilgen:load_local(funcname.var.ref)
    else
      compiler.ilgen:load_global(funcname.var.val)
    end
    for i = 1, (#funcname.indexes - 1) do
      compiler.ilgen:load_string(funcname.indexes[i])
      compiler.ilgen:gettable()
    end
    local tab = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(tab)
    local val = compiler.ilgen:get_temp()
    compiler.ilgen:store_local(val)
    compiler.ilgen:load_local(tab)
    compiler.ilgen:load_string(funcname.indexes[#funcname.indexes])
    compiler.ilgen:load_local(val)
    compiler.ilgen:settable()
    compiler.ilgen:release_temp(tab)
    compiler.ilgen:release_temp(val)
  end
end

function visitor.name(compiler, name)
  if name.ref then
    compiler.ilgen:load_local(name.ref)
  else
    compiler.ilgen:load_global(name.val)
  end
end

function visitor.binop(compiler, binop)
  compiler.ilgen:binop(binop.op, function () compiler:compile(binop.left) end,
		   function () compiler:compile(binop.right) end)
end

function visitor.unop(compiler, unop)
  compiler.ilgen:unop(unop.op, function () compiler:compile(unop.operand) end)
end

function visitor.call(compiler, call)
  local self_arg = compiler.ilgen:get_temp()
  visitor.primaryexp(compiler, call)
  if call.method then
    compiler.ilgen:emit(OpCodes.dup)
    compiler.ilgen:store_local(self_arg)
    compiler.ilgen:load_string(call.method)
    compiler.ilgen:gettable()
    table.insert(call.args, 1, { tag = "name", ref = self_arg })
  end
  local nargs = compiler.ilgen:argslist(call.args)
  compiler.ilgen:call(nil, nargs)
  if call.method then
    table.remove(call.args, 1)
  end
  compiler.ilgen:release_temp(self_arg)
end

function compile(compiler, node)
  if node.tag then 
    visitor[node.tag](compiler, node)
  else
    if node == "nil" then
      compiler.ilgen:load_nil()
    elseif node == "true" then
      compiler.ilgen:load_true()
    elseif node == "false" then
      compiler.ilgen:load_false()
    else
      error("node " .. node .. "not supported by compiler yet")
    end
  end
end

