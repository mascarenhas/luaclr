-- Symbol table

module(..., package.seeall)

function new()
  local st = {}
  setmetatable(st, { __index = _M })
  return st
end

function _M:enter(func)
  local level = { func = (func or self[#self].func) }
  if func then
    func.args = {}
    func.locals = {}
    func.upvals = {}
  end
  self[#self + 1] = level
end

function _M:leave()
  self[#self] = nil
end

function _M:add(name, isarg)
  local level = self[#self]
  local var = { name = name, func = level.func }
  if isarg then
    var.isarg = true
    level.func.args[#level.func.args + 1] = var
  else
    level.func.locals[#level.func.locals + 1] = var
  end
  level[name] = var
  return var
end

function _M:search(name)
  for i=#self, 1, -1 do
    if self[i][name] then
      local var = self[i][name]
      local this_func = self[#self].func
      local var_func = self[i].func
      if var_func ~= this_func then
	var.isupval = true
	for j = i, #self, 1 do
	  local middle_func = self[j].func
	  if middle_func ~= var_func then
	    middle_func.upvals[var] = true
	  end
        end
      end
      return var
    end
  end
  return nil
end

