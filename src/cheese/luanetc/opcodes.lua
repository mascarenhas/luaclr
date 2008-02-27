local rawset = rawset
local setmetatable = setmetatable

module(...)

local function opcode(name)
  return name:gsub("_", "."):gsub("tail.", "tail. ")
end

setmetatable(_M, { __index = function (tab, name)
			       local op = opcode(name)
			       rawset(tab, name, op)
			       return op
			     end })  
