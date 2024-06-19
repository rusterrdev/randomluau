local Class = {}


function Class.new<Item>(Hash: { [Item]: number })

    local dropsTable = if Hash
        then table.clone(Hash)
        else {}
    
    local self = {}

    local function getMagnitude()
        local Magnitude = 0


        for index, value in dropsTable do
            
            if typeof(value) ~= "number" then 
                continue
            end
    
    
            Magnitude += value
        end

        return Magnitude
    end
  
    local function choice(randomRate: number)
        local _choice = nil

        local rate = 0


        for index, value in dropsTable do 
            
           rate+=value

           if randomRate <= rate then
                return index
           end

        end
        return select(1, unpack(dropsTable))

    end

    function self:Sort(luck: number?, ...: Item)
    
        local _dropsTable = table.clone(dropsTable)


        local randomRate = nil


        if luck then
            local Items = table.pack(...)
            Items.n = nil
            print('luck')

            for _, item in Items do
                
                _dropsTable[item] *= luck
                print(_dropsTable)

            end            
          randomRate = math.random() * getMagnitude()

        else

         randomRate = math.random() * getMagnitude()

        end
        
        return choice(randomRate)
    end

    function self:getPercentage(Item: Item)
        
        local magnitude = getMagnitude()
            local itemRate = dropsTable[Item] or 0
            if magnitude == 0 then
                return 0
            end
        return (itemRate / magnitude) * 100
    end
   

    

    return self

end


return Class
