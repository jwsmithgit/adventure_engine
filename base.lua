local BaseClass = {}
BaseClass.__index = BaseClass

--[[setmetatable(BaseClass, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})]]

function BaseClass:new(init)
  local self = setmetatable({}, BaseClass)
  self.value = init
  return self
end

function BaseClass:set_value(newval)
  self.value = newval
end

function BaseClass:get_value()
  return self.value
end

return BaseClass