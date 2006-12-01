-- AST dumper

module("cheese.luap.dump", package.seeall)

function dump(tree, level)
  level = level or 0
  if type(tree) == "table" then
    return _G["dump_" .. tree.tag](tree, level)
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
		 "," .. dump(dnfor.finish) .. step .. " do")
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
  if sclocal.exps then exps = " = " .. dump_list(slocal.exps) end
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
  return string.rep(" ", level) .. "return " .. dump_list(sassign.exps)
end

function dump_list(list, level)
  local out = {}
  level = level or 0
  for _, item in ipairs(list) do
    table.insert(out, dump(item, level))
  end
  return table.concat(out, ",")
end

function dump_var(svar, level)
  local out = {}
  level = level or 0
  table.insert(out, dump(svar.prefix, level))
  for _, item in ipairs(svar.indexes) do
    table.insert(out, dump(item, level))
  end
  return table.concat(out)
end

function dump_call(scall, level)
  local out = {}
  level = level or 0
  local method = ""
  if scall.method then method = ":" .. scall.method end
  return string.rep(" ", level) .. dump_var(scall, level) ..
    method .. "(" .. dump_list(scall.args) .. ")"
end

function dump_primaryexp(pexp, level)
  return dump_var(pexp, level)
end

function dump_method(mcall, level)
end
