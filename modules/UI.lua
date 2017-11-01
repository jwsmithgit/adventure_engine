local Text = require('modules/Text')

local UI = class('UI')

function UI:initialize( )
    self.actions = {
        'move',
        'inspect',
        'talk',
        'take',
        'use'
    }

    self.space_x = 10
    self.space_y = 10

    self.ui = {}
    self.current_ui = nil

    self.font = love.graphics.newImageFont('sprites/imagefont.png',
        ' abcdefghijklmnopqrstuvwxyz' ..
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0' ..
        '123456789.,!?-+/():;%&`\'*#=[]"')
end

function UI:update( dt )
    for i,v in ipairs(self.ui) do v:update( dt ) end
end

function UI:draw( )
    for i,v in ipairs(self.ui) do v:draw() end
end

function UI:createActionContext( x, y )
    self.current_ui = 'action'
    self.x = x
    self.y = y
    for i,v in ipairs( self.actions ) do
        table.insert( self.ui, Text:new( {text = v, font = self.font, x = self.x + self.space_x, y = self.y + (i*self.space_y) + ((i-1)*self.font:getHeight())} ))
    end
end

function UI:createItemContext( list )
    self.current_ui = 'item'
    for i,v in ipairs( list ) do
        table.insert( self.ui, Text:new( {text = v, font = self.font, x = self.x + self.space_x, y = self.y + (i*self.space_y) + ((i-1)*self.font:getHeight())} ))
    end
end

function UI:createText( text )
    self.current_ui = 'text'
    table.insert( self.ui, Text:new( {text = text, font = self.font, x = self.x + self.space_x, y = self.y + self.space_y} ))
end

function UI:destroyContext( ) self.ui = { } end

function UI:isActive( )
    if #self.ui > 0 then return true end
    return false
end

function UI:type( ) return self.current_ui end

function UI:collision( x, y )
    for i,v in ipairs(self.ui) do
        if v:collision( x, y ) then
            return v:getText()
        end
    end
    return nil
end

return UI