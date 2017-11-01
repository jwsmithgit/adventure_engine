local GameObject = require ('modules/GameObject')
local Room = class('Room', GameObject)

local Sound = require('modules/Sound')

function Room:initialize( options )
    GameObject.initialize( self, options )

    self.objects = {}
    for k,v in pairs( options.objects or {} ) do self.objects[k] = GameObject:new(v) end

    self.sounds = {}
    for k,v in pairs( options.sounds ) do self.sounds[k] = Sound:new(v) end

    self.scripts = options.scripts
    self.active_scripts = {}
    self.active_actions = {}
    if self.scripts.enter ~= nil then
        for k,v in pairs(self.scripts.enter) do table.insert( self.active_scripts, v ) end
    end
end

function Room:update( dt )
    for k,v in pairs(self.sounds) do v:update( dt ) end

    --[[for i,v in ipairs(self.active_scripts) do
        for j,w in ipairs(v:update( dt )) do table.insert( self.active_actions, w ) end
    end]]

    for i,v in ipairs(self.active_actions) do
        done = self.objects[v.object][v.action](v.options)
    end
end

function Room:draw()
    GameObject.draw( self )
    for k,v in pairs(self.objects) do v:draw( ) end
end

function Room:collision( x, y )
    for i, v in ipairs(self.objects) do
        if v:collision( x, y ) then
            return v
        end
    end
    return self
end

function Room:addObject( name, options )
    self.objects[name] = GameObject:new( options )
end

function Room:removeObject( name )
    self.objects[name] = nil
end

return Room
