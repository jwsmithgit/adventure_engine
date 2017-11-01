local GameObject = class('GameObject')

function GameObject:initialize( options )
    self.initial = dofile('data/object_default.lua')
    for k,v in pairs( options ) do self.initial[k] = v end

    local meta = getmetatable(self)
    setmetatable(self.initial, meta)
    setmetatable( self, {__index=self.initial})
    local state = self.state
    if state ~= nil then
        setmetatable(self[state], {__index=self.initial})
        setmetatable(self, {__index=self[state]})
    end

    self.image = love.graphics.newImage( self.sprite )
end

function GameObject:update( dt )
end

function GameObject:draw( )
    if self.visible == true then
        love.graphics.draw(self.image, self.x + self.xo, self.y + self.yo)
    end
end

function GameObject:collision( x, y )
    if x >= self.x + self.xo and x < self.x + self.xo + self.image:getWidth( ) and y >= self.y + self.yo and y < self.y + self.yo + self.image:getHeight( ) then
        return true
    end
    return false
end

function GameObject:changeState( state )
    self.state = state
    setmetatable(self[state], {__index=self.initial})
    setmetatable(self, {__index=self[state]})

    self.image = love.graphics.newImage( self.sprite )
end

function GameObject:show( )
    self.visible = true
    return true
end

function GameObject:hide( )
    self.visible = false
    return true
end

function GameObject:move( options )
    local destx = options.x
    local desty = options.y
    if x == destx and y == desty then return true end

    local move_angle = math.tan((self.y-desty)/(self.x/destx))
    local movey = math.sin --ang = sin(opp/hyp) -- hyp = -sin(ang)
end

return GameObject
