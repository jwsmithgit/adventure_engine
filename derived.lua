local BaseClass = require('base')
local DerivedClass = {}
setmetatable(DerivedClass, BaseClass)
DerivedClass.__index = DerivedClass

--[[setmetatable(DerivedClass, {
  __index = BaseClass, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})]]

function DerivedClass:new(init)
  local self = BaseClass.new(self, init) -- call the base class constructor
  setmetatable(self, DerivedClass)
  self.value2 = init
  return self
end

function DerivedClass:get_value()
  return self.value + self.value2
end

return DerivedClass