local utilities = {}

function utilities:printTable( table )
    for k,v in pairs( table ) do
        print(k)

        if type(v) == 'table' then
            printtable(v)
        else
            print(v)
        end
    end
end

return utilities