local Provinces = {}
Provinces.canvas = nil

Provinces.maskData = nil
Provinces.seaR, Provinces.seaG, Provinces.seaB = 0, 0, 0
Provinces.tolerance = 0.05

local function getDistSq(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return dx * dx + dy * dy
end

function Provinces.generate(mapWidth, mapHeight, citiesList)
    local provinceData = love.image.newImageData(mapWidth, mapHeight)
    
    Provinces.maskData = love.image.newImageData("Data/Images/spain_map.png")
    Provinces.seaR, Provinces.seaG, Provinces.seaB = Provinces.maskData:getPixel(0, 0)
    
    for y = 0, mapHeight - 1 do
        for x = 0, mapWidth - 1 do
            local r, g, b, alpha = Provinces.maskData:getPixel(x, y)

            local isSea = math.abs(r - Provinces.seaR) < Provinces.tolerance and 
                          math.abs(g - Provinces.seaG) < Provinces.tolerance and 
                          math.abs(b - Provinces.seaB) < Provinces.tolerance

            if not isSea then 
                local closestCity = nil
                local minDistSq = math.huge

                for _, city in ipairs(citiesList) do
                    local distSq = getDistSq(x, y, city.x, city.y)
                    if distSq < minDistSq then
                        minDistSq = distSq
                        closestCity = city
                    end
                end

                if closestCity and closestCity.ownerColor then
                    local color = closestCity.ownerColor
                    provinceData:setPixel(x, y, color[1], color[2], color[3], 1)
                else
                    provinceData:setPixel(x, y, 0.7, 0.7, 0.7, 1)
                end
            else
                provinceData:setPixel(x, y, 0, 0, 0, 0)
            end
        end
    end

    Provinces.canvas = love.graphics.newImage(provinceData)
end

function Provinces.getCityAt(worldX, worldY, citiesList)
    if not citiesList or type(citiesList) ~= "table" then 
        return nil 
    end

    if not Provinces.maskData then return nil end
    if worldX < 0 or worldX >= Provinces.maskData:getWidth() or 
       worldY < 0 or worldY >= Provinces.maskData:getHeight() then
        return nil
    end

    local r, g, b = Provinces.maskData:getPixel(worldX, worldY)
    local isSea = math.abs(r - Provinces.seaR) < Provinces.tolerance and 
                  math.abs(g - Provinces.seaG) < Provinces.tolerance and 
                  math.abs(b - Provinces.seaB) < Provinces.tolerance
    if isSea then return nil end

    local closestCity = nil
    local minDistSq = math.huge

    for _, city in ipairs(citiesList) do
        local distSq = getDistSq(worldX, worldY, city.x, city.y)
        if distSq < minDistSq then
            minDistSq = distSq
            closestCity = city
        end
    end

    return closestCity
end

return Provinces