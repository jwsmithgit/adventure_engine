local modules, objects

function love.load()
    class = require 'lib/middleclass'

    _local = {}
    _local.__index = _local
    setmetatable(_G, _local)
    local modules = {
        'Actioner',
        'Cursor',
        'GameObject',
        'Inventory',
        'Room',
        'Text',
        'UI',
    }

    for k,r in ipairs(modules) do
		_local[r] = require ('modules/' .. r)
	end

    local width = 960
    local height = 540
    love.window.setMode( width, height, {fullscreen = false} )

    objects = {
        cursor = Cursor:new( ),
        inventory = Inventory:new( ),
        room = Room:new( dofile('data/alley.lua') ),
        ui = UI:new( ),
    }

end

function love.update( dt )
    for k,v in pairs(objects) do
        v:update( dt )
    end
end

function love.draw()
    objects.room:draw()
    objects.ui:draw()
    objects.cursor:draw()
end

function love.keypressed(key)
    if key == 'space' then
        love.event.quit()
    end
end

function love.mousepressed( x, y, button, istouch )
    if objects.ui:isActive() == false then
        objects.actioner = Actioner:new( )

        local object = objects.room:collision( x, y )
        objects.actioner:setObject( object )

        objects.ui:createActionContext( x, y )

    elseif objects.ui:isActive() and objects.ui:type() == 'action' then
        local action = objects.ui:collision( x, y )
        objects.actioner:setAction( action )

        objects.ui:destroyContext()

        if action == 'use' then
            objects.ui:createItemContext( objects.inventory:getItems())
        elseif action ~= nil then
            local actions = objects.actioner:parseAction()
            for i,v in ipairs( actions ) do print(v[1]) print(v[2]) print(v[3]) objects[v[1]][v[2]]( objects[v[1]], v[3] or nil) end
        end
        
    elseif objects.ui:isActive( ) and objects.ui:type() == 'item' then
        local item = objects.ui:collision( x, y )
        objects.actioner:setItem( item )

        objects.ui:destroyContext()

        if item ~= nil then
            local actions = objects.actioner:parseAction()
            for i,v in ipairs( actions ) do print(v[1]) print(v[2]) print(v[3]) objects[v[1]][v[2]]( objects[v[1]], v[3] or nil) end
        end

    elseif objects.ui:isActive( ) and objects.ui:type() == 'text' then
        objects.ui:destroyContext()
    end
end