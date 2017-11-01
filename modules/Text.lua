local GameObject = require ('modules/GameObject')
local Text = class('Text', GameObject)

function Text:initialize( options )
    GameObject.initialize( self, options )

    -- text to print
    self.text = options.text or ''
    self.print = 1

    -- how fast to print, character per seconds
    self.speed = options.speed or 0.05
    self.timer = self.speed

    if options.image_font then
        self.font = love.graphics.newImageFont('options.image_font',
        ' abcdefghijklmnopqrstuvwxyz' ..
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0' ..
        '123456789.,!?-+/():;%&`\'*#=[]"')
    elseif options.font then
        self.font = options.font
    elseif options.font_path then
        self.font = love.graphics.newFont( self.font_path, options.size or 12 )
    else
        self.font = love.graphics.newFont( 12 )
    end

    self.width = options.width or 1280
    self.height = options.height or 720

    self:format()
end

function Text:update( dt )
    while self.timer <= 0 and self.print < string.len(self.text) do
        self.print = self.print + 1

        if self.font:getWidth( self.text:sub( 1, self.print ) ) > self.width then
            self.text = self.text:sub(1, self.print-1 )..'\n'..self.text:sub(self.print)
        end

        self.timer = self.speed
    end

    self.timer = self.timer - 1*dt
end

function Text:draw( )
    love.graphics.setFont( self.font )
    love.graphics.print( self.text:sub( 1, self.print ), self.x, self.y)
end

function Text:format( )
    local i = 1
    while i < #self.text do
        if self.font:getWidth( self.text:sub( 1, self.print ) ) > self.width then
            self.text = self.text:sub(1, self.print-1 )..'\n'..self.text:sub(self.print)
        end
        i = i+1
    end

end 

function Text:collision( x, y )
    if x >= self.x and x < self.x + self.font:getWidth( self.text ) and y >= self.y and y < self.y + self.font:getHeight( ) then
        return true
    end
    return false
end

function Text:isActive( ) if self.text:len() > 0 then return true end return false end

function Text:destroy( ) self.text = '' end

function Text:getText( ) return self.text end

return Text