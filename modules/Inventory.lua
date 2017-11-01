local Inventory = class('Inventory')

function Inventory:initialize(  )
    self.items = {
        'cigarette'
    }
end

function Inventory:update( dt )
end

function Inventory:draw( )
end

function Inventory:addItem( item ) table.insert( self.items, item ) end

function Inventory:getItems( ) return self.items end

return Inventory