require("ui_tools")

local selection = {}
local iposx, iposy

selection.inspect = {}
selection.inspect.x = 0
selection.inspect.y = windhchunk * 10
selection.inspect.width = windwchunk * 5
selection.inspect.height = windhchunk * 10

-- Helper function for converting city world coordinates to screen rendering coordinates
local function getCityRenderPos(city, map, zoom)
    local z = zoom or 1
    local renderX = (map and map.x or 0) + (city.x * z)
    local renderY = (map and map.y or 0) + (city.y * z)
    return renderX, renderY
end

function selection.mousepressed(x, y, button)
    if button == 1 then
        iposx, iposy = x, y
    end
end

function selection.mousereleased(x, y, button, citiesList, map, zoom)
    if button ~= 1 or not iposx or not iposy or not citiesList then return end

    local shiftDown = love.keyboard.isDown("lshift", "rshift")
    local dragDistance = math.sqrt((x - iposx)^2 + (y - iposy)^2)
    local isClick = dragDistance < 5

    if isClick then
        -- Single-click detection using hit radius
        local hitRadius = 15
        local clickedCity = nil

        for _, city in ipairs(citiesList) do
            if city.x and city.y then
                local renderX, renderY = getCityRenderPos(city, map, zoom)
                local distSq = (x - renderX)^2 + (y - renderY)^2
                if distSq <= hitRadius^2 then
                    clickedCity = city
                    break
                end
            end
        end

        for _, city in ipairs(citiesList) do
            if city == clickedCity then
                city.selected = shiftDown and not city.selected or true
            elseif not shiftDown then
                city.selected = false
            end
        end
    else
        -- Drag box selection
        local x1, x2 = math.min(iposx, x), math.max(iposx, x)
        local y1, y2 = math.min(iposy, y), math.max(iposy, y)

        for _, city in ipairs(citiesList) do
            if city.x and city.y then
                local renderX, renderY = getCityRenderPos(city, map, zoom)
                local inside = (renderX >= x1 and renderX <= x2 and renderY >= y1 and renderY <= y2)

                if inside then
                    city.selected = true
                elseif not shiftDown then
                    city.selected = false
                end
            end
        end
    end

    iposx, iposy = nil, nil
end

function selection.draw()
    if gamestate ~= "game" or not love.mouse.isDown(1) or not iposx or not iposy then
        return
    end

    local cposx, cposy = love.mouse.getPosition()
    local x1, x2 = math.min(iposx, cposx), math.max(iposx, cposx)
    local y1, y2 = math.min(iposy, cposy), math.max(iposy, cposy)
    local width, height = x2 - x1, y2 - y1

    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.rectangle("fill", x1, y1, width, height)

    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", x1, y1, width, height)

    -- Reset graphic state
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

function selection.inspect.draw(citiesList)
    if not citiesList then return end

    local selected_cities = 0
    local total_population = 0
    local total_tax_income = 0
    local singleCity = nil

    for _, city in ipairs(citiesList) do
        if city.selected then
            selected_cities = selected_cities + 1
            total_population = total_population + (city.population or 0)
            
            -- Calculate individual city tax fallback if tax_income is 0
            local income = (city.tax_income and city.tax_income > 0) 
                and city.tax_income 
                or math.floor((city.population or 0) * 0.001)
                
            total_tax_income = total_tax_income + income
            singleCity = city
        end
    end

    if selected_cities == 0 then return end

    local padding = 10
    local lineSpacing = 28
    local lineCount = (selected_cities == 1) and 5 or 3
    local panelHeight = windhchunk * 10
    local statsHeight = lineCount * lineSpacing + padding
    local textWidth = selection.inspect.width - (padding * 2)

    -- Panel Background
    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", selection.inspect.x, selection.inspect.y, selection.inspect.width, panelHeight)

    -- Stats Background
    love.graphics.setColor(205/255, 178/255, 131/255)
    love.graphics.rectangle("fill", selection.inspect.x + padding, selection.inspect.y + padding, textWidth, statsHeight)

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
        local taxIncome = (singleCity.tax_income and singleCity.tax_income > 0) 
            and singleCity.tax_income 
            or math.floor((singleCity.population or 0) * 0.001)

        love.graphics.printf(singleCity.name or "City", selection.inspect.x, currentY, selection.inspect.width, "center")
        currentY = currentY + lineSpacing

        love.graphics.printf("Population: " .. total_population, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Owner: " .. ownerText, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Controller: " .. controllerText, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Tax Income: " .. taxIncome, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
    else
        love.graphics.printf(selected_cities .. " Cities", selection.inspect.x, currentY, selection.inspect.width, "center")
        currentY = currentY + lineSpacing

        love.graphics.printf("Total Pop: " .. total_population, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Total Tax: " .. total_tax_income, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
    end

    -- UI Action Buttons
    local buttonColor = {135/255, 108/255, 61/255}
    local buttonY = selection.inspect.y + statsHeight + padding * 2
    local buttonH = windhchunk * 0.7

    newButton(selection.inspect.x + padding, buttonY, textWidth, buttonH, buttonColor, true, "Buildings")
    newButton(selection.inspect.x + padding, buttonY + windhchunk, textWidth, buttonH, buttonColor, true, "Units")
    newButton(selection.inspect.x + padding, buttonY + windhchunk * 2, textWidth, buttonH, buttonColor, true, "Ressources")

    -- Reset graphic state
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return selection