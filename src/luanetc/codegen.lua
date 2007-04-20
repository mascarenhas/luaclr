require"cheese.luac.st"

module(..., package.seeall)

OpCodes = {}

Compiler = {}

IlGen = {}

function IlGen:jump_if_false(to)
  self:emit(OpCodes.ldfld, Compiler.luavalue_ref)
  self:emit(OpCodes.ldfld, Compiler.nil_singleton)
  self:emit(OpCodes.beq, to)
  self:emit(OpCodes.ldfld, Compiler.luavalue_ref)
  self:emit(OpCodes.ldfld, Compiler.false_singleton)
  self:emit(OpCodes.beq, to)
end

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
  compiler.ilgen:emit(OpCodes.pop)
  compiler:compile(nwhile.block)
  compiler.ilgen:emit(OpCodes.br, test)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:emit(OpCodes.pop)
  compiler.ilgen:end_loop()
end

visitor["repeat"] = function (compiler, nrepeat)
  local top = compiler.ilgen:define_label()
  compiler.ilgen:start_loop()
  compiler.ilgen:emit(OpCodes.ldnull)
  compiler.ilgen:mark_label(top)
  compiler.ilgen:emit(OpCodes.pop)
  compiler:compile(nrepeat.block)
  compiler:compile(nrepeat.exp)
  compiler.ilgen:jump_if_false(top)
  compiler.ilgen:emit(OpCodes.pop)
  compiler.ilgen:end_loop()
end

visitor["if"] = function (compiler, nif)
  local out = compiler.ilgen:define_label()
  for _, clause in ipairs(nif.clauses) do
    local next = compiler.ilgen:define_label()
    compiler:compile(clause.cond)
    compiler.ilgen:jump_if_false(next)
    compiler.ilgen:emit(OpCodes.pop)
    compiler:compile(clause.block)
    compiler:ilgen:emit(OpCodes.br, out)
    compiler.ilgen:mark_label(next)
    compiler.ilgen:emit(OpCodes.pop)
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
  if nfor.step then
    local temp_step = compiler.ilgen:get_temp()
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
  compiler.ilgen:call(function ()
			compiler.ilgen:load_local(temp_iter)
		      end,
		      function ()
			compiler.ilgen:load_local(temp_state)
                      end,
		      function ()
			compiler.ilgen:load_local(temp_control)
                      end, #gfor.vars)
  for i = #gfor.vars, 1, -1 do
    compiler.ilgen:store_local(gfor.vars[i].ref)
  end
  local out = compiler.ilgen:define_label()
  compiler.ilgen:load_local(temp_control)
  compiler.ilgen:jump_if_nil(out)
  compiler.ilgen:emit(OpCodes.pop)
  compiler:compile(gfor.block)
  compiler.ilgen:mark_label(out)
  compiler.ilgen:emit(OpCodes.pop)
  compiler.ilgen:end_loop()
end

visitor["function"] = function (compiler, nfunction)
  compiler:start_function(nfunction)
  compiler:compile(nfunction.block)
  local func = compiler:end_function()
  compiler.ilgen:new_func(func)
  if nfunction.islocal then
    
    nfunction.name.ref = st:add(nfunction.name.val)
  elseif nfunction.name then
    tie_refs(st, nfunction.name)
  end
  for _, par in ipairs(nfunction.parlist) do
    par.ref = st:add(par.val)
  end
end

visitor["local"] = function (st, nlocal)
  for _, exp in ipairs(nlocal.exps) do
    tie_refs(st, exp)
  end
  for _, var in ipairs(nlocal.names) do
    var.ref = st:add(var.val)
  end
end

function visitor.assign(st, assign)
  for _, exp in ipairs(assign.exps) do
    tie_refs(st, exp)
  end
  for _, var in ipairs(assign.vars) do
    tie_refs(st, var)
  end
end

visitor["break"] = function (st, nbreak)
end

visitor["return"] = function (st, nreturn)
  for _, exp in ipairs(nreturn.exps) do
    tie_refs(st, exp)
  end
end

function visitor.var(st, var)
  tie_refs(st, var.prefix)
  for _, item in ipairs(var.indexes) do
    if not item.tag then
      for _, exp in ipairs(item) do
        tie_refs(st, exp)
      end
    else
      tie_refs(st, item)
    end
  end
end

function visitor.primaryexp(st, pexp)
  visitor.var(st, pexp)
end

function visitor.method(st, mcall)
  for _, exp in ipairs(mcall.args) do
    tie_refs(st, exp)
  end
end

function visitor.string(st, s)
end

function visitor.number(st, n)
end

function visitor.expindex(st, expindex)
  tie_refs(st, expindex.exp)
end

function visitor.nameindex(st, nameindex)
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

function visitor.funcname(st, funcname)
  tie_refs(st, funcname.var)
end

function visitor.name(st, name)
  name.ref = st:search(name.val)
end

function visitor.binop(st, binop)
  tie_refs(st, binop.left)
  tie_refs(st, binop.right)
end

function visitor.unop(st, unop)
  tie_refs(st, unop.operand)
end

function visitor.call(st, call)
  visitor.var(st, call)
  for _, arg in ipairs(call.args) do
    tie_refs(st, arg)
  end
end

function tie_refs(st, node)
  st = st or cheese.luac.st.new()
  if node and node.tag then visitor[node.tag](st, node) end
end
