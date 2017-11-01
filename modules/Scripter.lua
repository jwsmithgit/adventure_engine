local Scripter = class('Scripter')

function Scripter:initialize( options )
    for k,v in pairs(self.options) do self[k] = v end

    self.counter = 1
    self.wait = false
end

function Scripter:update( dt )
    local actions = {}
    while wait == false do

        local action = dofile('./data/action_default')
        for k,v in pairs(self[self.counter]) do action[k] = v end
        table.insert( actions, action )

        self.wait = action.wait
        self.counter = self.counter + 1

        if self[self.counter] == nil then table.insert( actions, {action = "end_script"} ) end
    end
    return actions
end

function Scripter:draw( )

end

return Scripter