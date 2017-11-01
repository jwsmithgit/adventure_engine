XmlParser = {}

local function file_exists(file)
    local f = io.open(file, 'rb')
    if f then f:close() end
    return f ~= nil
end

function XmlParser:parse(file)
    if not file_exists(file) then return {} end

    local data = { }
    local curr_table = data
    local table_path = { data }

    for line in io.lines(file) do 
        --innefficient regex please
        while( line:sub(1,1) == ' ' ) do
            line = line:sub(2)
        end

        if line:sub(1,1) == '<' then
            if line:find('<',2) then
                --two angle bracket sets == value found
                --get value name
                local close = line:find( '>' )
                local name = line:sub(2,close-1)
                --get value
                local open2 = line:find( '<', close+1 )
                local value = line:sub(close+1, open2-1)
                --assign value
                curr_table[name] = value
            elseif line:sub(2,2) == '/' then
                --1 end bracket == end table
                --set current table to previous table
                curr_table = table_path[ #table_path ]
                --remove table from stack
                table.remove( table_path )
            else
                --1 open bracket == start table
                --append current table to stack
                table.insert( table_path, curr_table )
                --get ne wtable name
                local close = line:find( '>' )
                local name = line:sub(2,close-1)
                -- create new table
                curr_table[name] = {}
                curr_table = curr_table[name]
            end
        end
    end
    return data
end

return XmlParser