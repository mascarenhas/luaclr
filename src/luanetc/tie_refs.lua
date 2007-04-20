require"cheese.luac.st"

module(..., package.seeall)

local visitor = {}

function visitor.block(st, block)
  for _, stat in ipairs(block) do
    tie_refs(st, stat)
  end
end

function visitor.chunk(st, chunk)
  st:enter(chunk)
  tie_refs(st, chunk.block)
  st:leave()
end

visitor["while"] = function (st, nwhile)
  tie_refs(st, nwhile.exp)
  st:enter()
  tie_refs(st, nwhile.block)
  st:leave()
end

visitor["repeat"] = function (st, nrepeat)
  st:enter()
  tie_refs(st, nrepeat.block)
  st:leave()
  tie_refs(st, nrepeat.exp)
end

visitor["if"] = function (st, nif)
  for _, clause in ipairs(nif.clauses) do
    tie_refs(st, clause.cond)
    st:enter()
    tie_refs(st, clause.block)
    st:leave()
  end
  st:enter()
  tie_refs(st, nif.block_else)
  st:leave()
end

visitor["do"] = function (st, ndo)
  st:enter()
  tie_refs(st, ndo.block)
  st:leave()
end

function visitor.nfor(st, nfor)
  tie_refs(st, nfor.start)
  tie_refs(st, nfor.finish)
  tie_refs(st, nfor.step)
  st:enter()
  nfor.var.ref = st:add(nfor.var.val)
  tie_refs(st, nfor.block)
  st:leave()
end

function visitor.gfor(st, gfor)
  for _, exp in ipairs(gfor.exps) do
    tie_refs(st, exp)
  end
  st:enter()
  for _, var in ipairs(gfor.vars) do
    var.ref = st:add(var.val)
  end
  tie_refs(st, gfor.block)
  st:leave()
end

visitor["function"] = function (st, nfunction)
  if nfunction.islocal then
    nfunction.name.ref = st:add(nfunction.name.val)
  elseif nfunction.name then
    tie_refs(st, nfunction.name)
  end
  st:enter(nfunction)
  for _, par in ipairs(nfunction.parlist) do
    par.ref = st:add(par.val)
  end
  tie_refs(st, nfunction.block)
  st:leave()
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
