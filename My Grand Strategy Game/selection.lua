require("ui_tools")
local cities = require("city_data") 

local selection = {}
local iposx, iposy

selection.inspect = {}
selection.inspect.x = 0
selection.inspect.y = windhchunk * 10
selection.inspect.width = windwchunk * 5
selection.inspect.height = windhchunk * 10

function selection.mousepressed(x, y, button)
    if button == 1 then
        iposx, iposy = x, y
    end
end

function selection.mousereleased(x, y, button, citiesList, map, zoom)
    if button == 1 and iposx and iposy then
        local shiftDown = love.keyboard.isDown("lshift", "rshift")
        
        -- Distance moved between mouse press and release
        local dragDistance = math.sqrt((x - iposx)^2 + (y - iposy)^2)
        local isClick = dragDistance < 5

        if citiesList then
            if isClick then
                -- Single-click detection using hit radius
                local hitRadius = 15 -- Clickable radius in pixels around city center
                local clickedCity = nil

                for _, city in ipairs(citiesList) do
                    if city.x and city.y then
                        local renderX = (map and map.x or 0) + (city.x * (zoom or 1))
                        local renderY = (map and map.y or 0) + (city.y * (zoom or 1))

                        local distSq = (x - renderX)^2 + (y - renderY)^2
                        if distSq <= hitRadius^2 then
                            clickedCity = city
                            break
                        end
                    end
                end

                for _, city in ipairs(citiesList) do
                    if city == clickedCity then
                        if shiftDown then
                            city.selected = not city.selected -- Toggle selection
                        else
                            city.selected = true
                        end
                    elseif not shiftDown then
                        city.selected = false
                    end
                end

            else
                -- Drag box selection
                local x1 = math.min(iposx, x)
                local y1 = math.min(iposy, y)
                local x2 = math.max(iposx, x)
                local y2 = math.max(iposy, y)

                for _, city in ipairs(citiesList) do
                    if city.x and city.y then
                        local renderX = (map and map.x or 0) + (city.x * (zoom or 1))
                        local renderY = (map and map.y or 0) + (city.y * (zoom or 1))

                        local inside = (renderX >= x1 and renderX <= x2 and 
                                       renderY >= y1 and renderY <= y2)

                        if inside then
                            city.selected = true
                        elseif not shiftDown then
                            city.selected = false
                        end
                    end
                end
            end
        end

        iposx, iposy = nil, nil
    end
end

function selection.draw()
    if gamestate ~= "game" or not love.mouse.isDown(1) or not iposx or not iposy then
        return
    end

    local cposx, cposy = love.mouse.getPosition()

    local x1 = math.min(iposx, cposx)
    local y1 = math.min(iposy, cposy)
    local x2 = math.max(iposx, cposx)
    local y2 = math.max(iposy, cposy)
    local width = x2 - x1
    local height = y2 - y1

    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.rectangle("fill", x1, y1, width, height)

    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", x1, y1, width, height)

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)


end

function selection.inspect.draw(citiesList)
    local selected_cities = 0
    local total_population = 0
    local singleCity = nil

    -- Aggregate data only for selected cities
    if citiesList then
        for _, city in ipairs(citiesList) do
            if city.selected then
                selected_cities = selected_cities + 1
                total_population = total_population + (city.population or 0)
                
                -- Track the last selected city
                singleCity = city
            end
        end
    end

    -- Only display the panel if cities are selected
    if selected_cities > 0 then
        local padding = 10
        local lineSpacing = 30
        local lineCount = (selected_cities == 1) and 4 or 2
        local panelHeight = windhchunk * 10

        -- Panel Background
        love.graphics.setColor(255/255, 228/255, 181/255)
        love.graphics.rectangle("fill", selection.inspect.x, selection.inspect.y, selection.inspect.width, panelHeight)

        -- Panel Border
        love.graphics.setColor(135/255, 108/255, 61/255)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", selection.inspect.x, selection.inspect.y, selection.inspect.width, panelHeight)

        -- Text Display
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(mediumfont)

        local currentY = selection.inspect.y + padding

        if selected_cities == 1 and singleCity then
            local ownerText = singleCity.owner or "Unclaimed"
            local controllerText = singleCity.controller or "Unclaimed"

            love.graphics.printf(singleCity.name or "City", selection.inspect.x, currentY, selection.inspect.width, "center")
            currentY = currentY + lineSpacing

            love.graphics.printf("Population: " .. total_population, selection.inspect.x + padding, currentY, selection.inspect.width - (padding * 2), "left")
            currentY = currentY + lineSpacing

            love.graphics.printf("Owner: " .. ownerText, selection.inspect.x + padding, currentY, selection.inspect.width - (padding * 2), "left")
            currentY = currentY + lineSpacing

            love.graphics.printf("Controller: " .. controllerText, selection.inspect.x + padding, currentY, selection.inspect.width - (padding * 2), "left")
        else
            love.graphics.printf("Selected: " .. selected_cities, selection.inspect.x, currentY, selection.inspect.width, "center")
            currentY = currentY + lineSpacing

            love.graphics.printf("Total Pop: " .. total_population, selection.inspect.x + padding, currentY, selection.inspect.width - (padding * 2), "left")
        end

        -- Reset graphic state
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return selection