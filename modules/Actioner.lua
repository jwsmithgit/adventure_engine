local Actioner = class('Actioner')

function Actioner:initialize()
    self.defaults = dofile('data/object_default.lua')
    self.object = nil
    self.action = nil
    self.item = nil
end

function Actioner:update( dt )
end

function Actioner:draw()
end

function Actioner:setObject( object ) self.object = object end
function Actioner:setAction( action ) self.action = action end
function Actioner:setItem( item ) self.item = item end

function Actioner:reset()
    self.object = nil
    self.action = nil
    self.item = nil
end

function Actioner:parseAction()
    local actions = nil
    if self.action == 'move' then
        actions = self:move( self.object )
    elseif self.action == 'inspect' then
        actions = self:inspect( self.object )
    elseif self.action == 'talk' then
        actions = self:talk( self.object )
    elseif self.action == 'take' then
        actions = self:take( self.object )
    elseif self.action == 'use' then
        actions = self:use( self.object, self.item )
    end

    if type(self.object[self.action]) == 'table' and self.object[self.action].state ~= nil then
        self.object:changeState( self.object[self.action].state )
    end

    return actions
end

function Actioner:move( object )
    local actions = {}
    local text = object.move
    if type(object.move) == 'table' then text = object.move.text end

    local filepath = 'data/'..text..'.lua'
    local f = io.open( filepath, 'r' )
    if f ~= nil then 
        io.close(f)

        print()
        local room = dofile( filepath )
        table.insert( actions, { 'room', 'initialize', room } )
    elseif text ~= nil then
        table.insert( actions, { 'ui', 'createText', text } )
    end
    
    return actions
end

function Actioner:inspect( object )
    local actions = {}

    local text = object.inspect
    if type(object.inspect) == 'table' then text = object.inspect.text end
    table.insert( actions, { 'ui', 'createText', text } )

    if object.inspect_count ~= nil then
        object:increment( 'inspect_count' )
    end

    return actions
end

function Actioner:talk( object )
    local actions = {}

    local text = object.talk
    if type(object.talk) == 'table' then text = object.talk.text end
    table.insert( actions, { 'ui', 'createText', text } )
    
    if object.talk_count ~= nil then
        object:increment( 'talk_count' )
    end

    return actions
end

function Actioner:take( object )
    local actions = {}

    local text = object.take
    if type(object.take) == 'table' then 
        text = object.take.text 
        item = object.take.item

        table.insert( actions, { 'inventory', 'addItem', item })
    end
    table.insert( actions, { 'ui', 'createText', text } )

    return actions
end

function Actioner:use( object, item )
    local actions = {}

    local text = object.use
    if type(object.use) == 'table' then 
        if item == object.use.item then
            text = object.use.text
        else
            text = self.defaults.use
        end
    end
    
    table.insert( actions, { 'ui', 'createText', text } )

    return actions
end

return Actioner