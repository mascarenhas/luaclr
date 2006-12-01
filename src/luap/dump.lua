-- AST dumper

module("cheese.luap.dump", package.seeall)

function dump(tree, level)
  level = level or 0
  if type(tree) == "table" and tree.tag then
    return _M["dump_" .. tree.tag](tree, level)
  else
    return string.rep(" ", level) .. tostring(tree)
  end
end

function dump_block(block, level)
  local out = {}
  local level = level or 0
  for _, stat in ipairs(block) do
    table.insert(out, dump(stat, level))
  end
  return table.concat(out, "\n")
end

function dump_chunk(chunk)
  return dump_block(chunk.block)
end

function dump_while(swhile, level)
  local out = {}
  level = level or 0
  table.insert(out, string.rep(" ", level) .. 
			       "while " .. dump(swhile.exp) .. " do")
  table.insert(out, dump_block(swhile.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_repeat(srepeat, level)
  local out = {}
  level = level or 0
  table.insert(out, string.rep(" ", level) ..
	       "repeat ")
  table.insert(out, dump_block(srepeat.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "until " ..
	       dump(srepeat.exp))
  return table.concat(out, "\n")
end

function dump_if(sif, level)
  local out = {}
  level = level or 0
  for i, clause in ipairs(sif.clauses) do
    local name
    if i == 1 then name = "if " else name = "elseif " end
    table.insert(out, string.rep(" ", level) ..
		 	       name .. dump(clause.cond) .. " then ")
    table.insert(out, dump_block(clause.block, level + 2))
  end
  if sif.block_else then
    table.insert(out, string.rep(" ", level) .. "else")
    table.insert(out, dump_block(sif.block_else, level + 2))
  end
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_do(sdo, level)
  local out = {}
  level = level or 0
  table.insert(out, string.rep(" ", level) .. "do")
  table.insert(out, dump_block(sdo.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_nfor(snfor, level)
  local out = {}
  level = level or 0
  local step = ""
  if snfor.step then
    step = "," .. dump(snfor.step)
  end
  table.insert(out, string.rep(" ", level) .. "for " ..
	       dump(snfor.var) .. "=" .. dump(snfor.start) ..
		 "," .. dump(snfor.finish) .. step .. " do")
  table.insert(out, dump_block(snfor.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_gfor(sgfor, level)
  local out = {}
  level = level or 0
  table.insert(out, string.rep(" ", level) .. "for " ..
	       dump_list(sgfor.vars) .. " in " ..
		 dump_list(sgfor.exps) .. " do")
  table.insert(out, dump_block(sgfor.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_function(sfunction, level)
  local out = {}
  level = level or 0
  local islocal, name = "", ""
  if sfunction.islocal then islocal = "local " end
  if sfunction.name then name = dump(sfunction.name) end
  table.insert(out, string.rep(" ", level) .. islocal .. "function " ..
	       name .. " (" .. dump_list(sfunction.parlist) .. ")")
  table.insert(out, dump_block(sfunction.block, level + 2))
  table.insert(out, string.rep(" ", level) .. "end")
  return table.concat(out, "\n")
end

function dump_local(slocal, level)
  level = level or 0
  local exps = ""
  if slocal.exps then exps = " = " .. dump_list(slocal.exps) end
  return string.rep(" ", level) .. "local " .. 
    dump_list(slocal.names) .. exps
end

function dump_assign(sassign, level)
  level = level or 0
  return string.rep(" ", level) ..  
    dump_list(sassign.vars) .. " = " .. dump_list(sassign.exps)
end

function dump_break(sbreak, level)
  return string.rep(" ", level) .. "break"
end

function dump_return(sreturn, level)
  level = level or 0
  return string.rep(" ", level) .. "return " .. dump_list(sreturn.exps)
end

function dump_list(list, level, break_n)
  local out = {}
  level = level or 0
  for i, item in ipairs(list) do
    local br = ""
    if break_n and (i % break_n) == 0 then
      br = "\n" .. string.rep(" ", level)
    end
    table.insert(out, br .. dump(item, level))
  end
  return table.concat(out, ",")
end

function dump_var(svar, level)
  local out = {}
  level = level or 0
  table.insert(out, dump(svar.prefix, level))
  for _, item in ipairs(svar.indexes) do
    if item.tag then
      table.insert(out, dump(item, level))
    else
      table.insert(out,"(" .. dump_list(item, level) .. ")") 
    end
  end
  return table.concat(out)
end

function dump_call(scall, level)
  local out = {}
  level = level or 0
  local method = ""
  if scall.method then method = ":" .. scall.method end
  return string.rep(" ", level) .. dump_var(scall, level) ..
    method .. "(" .. dump_list(scall.args, level) .. ")"
end

function dump_primaryexp(pexp, level)
  level = level or 0
  return dump_var(pexp, level)
end

function dump_method(mcall, level)
  level = level or 0
  return string.rep(" ", level) .. ":" .. mcall.method .. "(" ..
    dump_list(mcall.args, level) .. ")"
end

function dump_name(name, level)
  return name.val
end

function dump_string(s, level)
  return string.format("%q", s.val)
end

function dump_number(n, level)
  return tostring(n.val)
end

function dump_expindex(expindex, level)
  level = level or 0
  return "[" .. dump(expindex.exp, level) .. "]"
end

function dump_nameindex(nameindex, level)
  return "." .. nameindex.name
end

function dump_constructor(cons, level)
  level = level or 0
  return "{ " .. dump_list(cons.fields, level+2, 4) .. " }" 
end

function dump_namefield(namefield, level)
  level = level or 0
  return namefield.name .. "=" .. dump(namefield.exp, level)
end

function dump_indexfield(indexfield, level)
  level = level or 0
  return "[" .. dump(indexfield.name, level) .. "]=" .. 
    dump(indexfield.exp, level)
end

function dump_funcname(funcname, level)
  level = level or 0
  local indexes = table.concat(funcname.indexes, ".")
  if #funcname.indexes>0 then indexes = "." .. indexes end
  local self = ""
  if funcname.self then self = ":" .. funcname.self end
  return funcname.var.val .. indexes .. self
end

function dump_binop(binop, level)
  level = level or 0
  local op = binop.op
  if op == "and" or op == "or" then op = " " .. op .. " " end
  return "(" .. dump(binop.left, level) .. op .. 
    dump(binop.right, level) .. ")"
end

function dump_unop(unop, level)
  level = level or 0
  local op = unop.op
  if op == "not" then op = "not " end
  return op .. dump(unop.operand, level)
end

