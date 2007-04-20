-- Symbol table

module(..., package.seeall)

function new()
  local st = {}
  setmetatable(st, { __index = _M })
  return st
end

function _M:enter(func)
  local level = { func = func or self[#self].func }
  self[#self + 1] = level
end

function _M:leave()
  self[#self] = nil
end

function _M:add(name)
  local level = self[#self]
  local var = { name = name, func = level.func }
  if not level.func.locals then level.func.locals = {} end
  table.insert(level.func.locals, var)
  level[name] = var
  return var
end

function _M:search(name)
  for i=#self, 1, -1 do
    if self[i][name] then
      local var = self[i][name]
      local this_func = self[#self].func
      local var_func = self[i].func
      if var_func ~= this_func then var.isupval = true end
      return var
    end
  end
  return nil
end

