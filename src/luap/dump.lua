-- AST dumper

module("cheese.luap.dump", package.seeall)

function dump(tree, level)
  level = level or 0
  if type(tree) == "table" and tree.tag then
    return _M["dump_" .. tree.tag](tree, level)
  elseif type(tree) == "table"  then
    local out = {}
    for k, v in pairs(tree) do
      table.insert(out, tostring(k) .. "=" .. tostring(v))
    end
    return string.rep(" ", level) .. "{ " .. table.concat(out, ", ") .. " }"
  else
    error({ "invalid ast node " .. tostring(tree) })
  end
end

function dump_true()
  return "true"
end

function dump_false()
  return "false"
end

function dump_ellipsis()
  return "..."
end

function dump_nil()
  return "nil"
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
  table.insert(out, string.rep(" ", level) ..
	       "if " .. dump(sif.cond) .. " then ")
  table.insert(out, dump_block(sif.block, level + 2))
  while sif.block_else and #sif.block_else == 1 and
        sif.block_else[1].tag == "if" do
    sif = sif.block_else[1]
    table.insert(out, string.rep(" ", level) ..
	       "elseif " .. dump(sif.cond) .. " then ")
    table.insert(out, dump_block(sif.block, level + 2))
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
  table.insert(out, string.rep(" ", level) .. "function " ..
	       " (" .. dump_list(sfunction.parlist) .. ")")
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
  return dump(svar.ref, level)
end

function dump_call(scall, level)
  local out = {}
  level = level or 0
  local method = ""
  if scall.method then method = ":" .. scall.method end
  return string.rep(" ", level) .. dump(scall.func, level) ..
    method .. "(" .. dump_list(scall.args, level) .. ")"
end

function dump_index(pexp, level)
  level = level or 0
  return dump(pexp.table, level) .. "[" .. dump(pexp.index, level) .. "]"
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

