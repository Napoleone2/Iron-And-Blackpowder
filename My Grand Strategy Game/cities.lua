cities = {}

cities.list = require("city_data") 

function cities.load()
    
    local mapImg = love.graphics.newImage("Data/Images/spain_map.png")
    local mapW = mapImg:getWidth()
    local mapH = mapImg:getHeight()

    for i, city in ipairs(cities.list) do
        city.x = city.pctX * mapW
        city.y = city.pctY * mapH
    end
    print("Cities safely prepared with actual pixel locations!")
end

function cities.update(dt)
    
end

function cities.draw() 
    
    for _, city in ipairs(cities.list) do
        if city.x and city.y then
            
            local renderX = map.x + (city.x * zoom)
            local renderY = map.y + (city.y * zoom)
            
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.circle("fill", renderX, renderY, 14)
            
            if city.ownerColor then
                love.graphics.setColor(city.ownerColor[1], city.ownerColor[2], city.ownerColor[3], 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.circle("fill", renderX, renderY, 10)
        end
    end
    love.graphics.setColor(1, 1, 1, 1) -- Always reset canvas coloring
end