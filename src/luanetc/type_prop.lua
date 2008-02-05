-- Simple type propagation

module(..., package.seeall)

local visitor = {}

local diverge

function visitor.block(block)
  for _, stat in ipairs(block) do
    type_prop(stat)
  end
end

function visitor.chunk(chunk)
  visitor.block(chunk.block)
end

visitor["while"] = function (nwhile)
  type_prop(nwhile.exp)
  visitor.block(nwhile.block)
end

visitor["repeat"] = function (nrepeat)
  visitor.block(nrepeat.block)
  type_prop(nrepeat.exp)
end

visitor["if"] = function (nif)
  type_prop(nif.cond)
  visitor.block(nif.block)
  if nif.block_else then
    visitor.block(nif.block_else)
  end
end

visitor["do"] = function (ndo)
  visitor.block(ndo.block)
end

function visitor.nfor(nfor)
  type_prop(nfor.start)
  type_prop(nfor.finish)
  if nfor.step then
    type_prop(nfor.step)
  end
  local start_type = nfor.start.type
  local var_type = start_type or "any"
  if not nfor.var.ref.type then
    nfor.var.ref.type = var_type
    diverge = true
  elseif nfor.var.ref.type ~= "any" and var_type ~= nfor.var.ref.type then
    nfor.var.ref.type = "any"
    diverge = true
  end
  visitor.block(nfor.block)
end

function visitor.gfor(gfor)
  for _, exp in ipairs(gfor.exps) do
    type_prop(exp)
  end
  visitor.block(gfor.block)
end

visitor["function"] = function (nfunction)
  visitor.block(nfunction.block)
end

visitor["local"] = function (nlocal)
  for _, exp in ipairs(nlocal.exps or {}) do
    type_prop(exp)
  end
  for i, var in ipairs(nlocal.names) do
    local exp_type = ((nlocal.exps or {})[i] or {}).type
    if exp_type and not var.ref.type then
      var.ref.type = exp_type
      diverge = true
    elseif var.ref.type ~= "any" and exp_type ~= var.ref.type then
      var.ref.type = "any"
      diverge = true
    end
  end
end

function visitor.assign(assign)
  for _, exp in ipairs(assign.exps or {}) do
    type_prop(exp)
  end
  for i, var in ipairs(assign.vars) do
    local exp_type = ((assign.exps or {})[i] or {}).type or "any"
    if var.ref.tag == "name" and var.ref.ref and not var.ref.ref.type then
      var.ref.ref.type = exp_type
      diverge = true
    elseif var.ref.tag == "name" and var.ref.ref and var.ref.ref.type ~= "any" and var.ref.ref.type ~= exp_type then
      var.ref.ref.type = "any"
      diverge = true
    end
    type_prop(var)
  end
end

visitor["return"] = function (nreturn)
  for _, exp in ipairs(nreturn.exps) do
    type_prop(exp)
  end
end

function visitor.var(var)
  type_prop(var.ref)
  local type = var.ref.type or "any"
  if not var.type then
    var.type = type
    diverge = true
  elseif var.type ~= "any" and var.type ~= var.ref.type then
    var.type = "any"
    diverge = true
  end
end

function visitor.index(pexp)
  type_prop(pexp.table)
  type_prop(pexp.index)
end

function visitor.constructor(cons)
  for _, field in ipairs(cons.fields) do
    type_prop(field)
  end
end

function visitor.namefield(namefield)
  type_prop(namefield.exp)
end

function visitor.indexfield(indexfield)
  type_prop(indexfield.name)
  type_prop(indexfield.exp)
end

function visitor.name(name)
  local type = (name.ref or {}).type or "any"
  if not name.type then
    name.type = type
    diverge = true
  elseif name.type ~= "any" and name.type ~= type then
    name.type = "any"
    diverge = true
  end
end

function visitor.binop(binop)
  local arith_ops = { ["+"] = "add", ["-"] = "sub", ["/"] = "div",
    ["*"] = "mul", ["%"] = "rem", ["^"] = "exp", ["and"] = true,
    ["or"] = true
  }
  type_prop(binop.left)
  type_prop(binop.right)
  local binop_type
  if arith_ops[binop.op] and binop.left.type == binop.right.type then
    binop_type = binop.left.type
  end
  binop_type = binop_type or "any"
  if not binop.type then
    binop.type = binop_type
    diverge = true
  elseif binop.type ~= "any" and binop.type ~= binop_type then
    binop.type = "any"
    diverge = true
  end
end

function visitor.unop(unop)
  type_prop(unop.operand)
  local unop_type = unop.operand.type or "any"
  if not unop.type then
    unop.type = unop_type
    diverge = true
  elseif unop.type ~= "any" and unop.type ~= unop_type then
    unop.type = "any"
    diverge = true
  end
end

function visitor.call(call)
  type_prop(call.func)
  for _, arg in ipairs(call.args) do
    type_prop(arg)
  end
  call.type = "any"
end

function type_prop(node)
  if node and node.tag then
    if visitor[node.tag] then visitor[node.tag](node) end
  else
    error("invalid AST node")
  end
end

function infer(tree)
  repeat
    diverge = false
    type_prop(tree)
  until not diverge
end
