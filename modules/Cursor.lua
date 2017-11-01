local GameObject = require('modules/GameObject')
local Cursor = class('Cursor', GameObject)

function Cursor:initialize( )
    self.cursor = love.mouse.newCursor('sprites/cursor.png', 0, 0)
    love.mouse.setCursor(self.cursor)
end

function Cursor:update( dt )

end

function Cursor:draw( )
    
end

return Cursor