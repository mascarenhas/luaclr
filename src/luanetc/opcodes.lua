local rawset = rawset
local setmetatable = setmetatable

module(...)

local function opcode(name)
  return name:gsub("_", ".")
end

setmetatable(_M, { __index = function (tab, name)
			       local op = opcode(name)
			       rawset(tab, name, op)
			       return op
			     end })  
