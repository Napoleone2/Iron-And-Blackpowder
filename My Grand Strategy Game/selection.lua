require("ui_tools")

local selection = {}
local iposx, iposy

selection.inspect = {}
selection.inspect.x = 0
selection.inspect.y = windhchunk * 10
selection.inspect.width = windwchunk * 5
selection.inspect.height = windhchunk * 10

local function getCityRenderPos(city, map, zoom)
    local z = zoom or 1
    local renderX = (map and map.x or 0) + (city.x * z)
    local renderY = (map and map.y or 0) + (city.y * z)
    return renderX, renderY
end

function selection.mousepressed(x, y, button)
    if button == 1 then
        if selection.inspect.buttons then
            for menuKey, btn in pairs(selection.inspect.buttons) do
                if x >= btn.x and x <= btn.x + btn.w and y >= btn.y and y <= btn.y + btn.h then
                    if selection.inspect.activeMenu == menuKey then
                        selection.inspect.activeMenu = nil
                    else
                        selection.inspect.activeMenu = menuKey
                    end
                    return 
                end
            end
        end

        iposx, iposy = x, y
    end
end

function selection.mousereleased(x, y, button, citiesList, map, zoom)
    if button ~= 1 or not iposx or not iposy or not citiesList then return end

    local shiftDown = love.keyboard.isDown("lshift", "rshift")
    local dragDistance = math.sqrt((x - iposx)^2 + (y - iposy)^2)
    local isClick = dragDistance < 5

    if isClick then
        
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

local function drawRessourcesMenu(citiesList, x, y, width, height)
    local totals = { iron = 0, wood = 0, stone = 0, coal = 0, rifles = 0, steel = 0, ammunition = 0, blackpowder = 0}
    for _, city in ipairs(citiesList) do
        if city.selected and city.resource_output then
            for res, val in pairs(totals) do
                totals[res] = val + (city.resource_output[res] or 0)
            end
        end
    end

    local lineY = y + 40
    love.graphics.setLineWidth(2)
    love.graphics.setColor(colors.lightest)
    love.graphics.rectangle("fill", x + width, y, width, height)
    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("line", x + width, y, width, height)

    love.graphics.setColor(colors.dark)
    love.graphics.rectangle("fill", x + width + 10, y + 10, width - 20, height - 20)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Resource Output", x + width, y + 10, width, "center")

    for resName, amount in pairs(totals) do
        love.graphics.printf(resName:upper() .. ": " .. amount, x + width + 20, lineY, width - 20, "left")
        lineY = lineY + 22
    end
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
            local tier = city.tier or 1
            selected_cities = selected_cities + 1
            total_population = total_population + (city.population or 0)
            
            local income = (city.tax_income and city.tax_income > 0) 
                and city.tax_income 
                or math.floor(((city.population or 0) * tier) * 0.00001)
                
            total_tax_income = total_tax_income + income
            singleCity = city
        end
    end

    if selected_cities == 0 then return end

    local padding = 10
    local lineSpacing = 28
    local lineCount = (selected_cities == 1) and 6 or 3 
    local panelHeight = windhchunk * 10
    local statsHeight = lineCount * lineSpacing + padding * 2
    local textWidth = selection.inspect.width - (padding * 2)

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", selection.inspect.x, selection.inspect.y, selection.inspect.width, panelHeight)

    love.graphics.setColor(205/255, 178/255, 131/255)
    love.graphics.rectangle("fill", selection.inspect.x + padding, selection.inspect.y + padding, textWidth, statsHeight)

    love.graphics.setColor(135/255, 108/255, 61/255)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", selection.inspect.x, selection.inspect.y, selection.inspect.width, panelHeight)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(mediumfont)

    local currentY = selection.inspect.y + padding

    if selected_cities == 1 and singleCity then
        local ownerText = singleCity.owner or "Unclaimed"
        local controllerText = singleCity.controller or "Unclaimed"
        local singleTier = singleCity.tier or 1
        local taxIncome = (singleCity.tax_income and singleCity.tax_income > 0) 
            and singleCity.tax_income 
            or math.floor(((singleCity.population or 0) * singleTier) * 0.00001)

        love.graphics.printf(singleCity.name or "City", selection.inspect.x, currentY, selection.inspect.width, "center")
        currentY = currentY + lineSpacing

        love.graphics.printf("Population: " .. total_population, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Owner: " .. ownerText, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Controller: " .. controllerText, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Tax Income: " .. taxIncome, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("City Tier: " .. singleTier, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing
    else
        love.graphics.printf(selected_cities .. " Cities", selection.inspect.x, currentY, selection.inspect.width, "center")
        currentY = currentY + lineSpacing

        love.graphics.printf("Total Pop: " .. total_population, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
        currentY = currentY + lineSpacing

        love.graphics.printf("Total Tax: " .. total_tax_income, selection.inspect.x + padding * 2, currentY, textWidth - padding, "left")
    end

    local buttonColor = {135/255, 108/255, 61/255}
    local buttonY = selection.inspect.y + statsHeight + padding * 2
    local buttonH = windhchunk * 0.7

    selection.inspect.buttons = {
        buildings  = { x = selection.inspect.x + padding, y = buttonY, w = textWidth, h = buttonH, text = "Buildings" },
        units      = { x = selection.inspect.x + padding, y = buttonY + windhchunk * 0.9, w = textWidth, h = buttonH, text = "Units" },
        ressources = { x = selection.inspect.x + padding, y = buttonY + windhchunk * 1.8, w = textWidth, h = buttonH, text = "Ressources" }
    }

    newButton(selection.inspect.buttons.buildings.x, selection.inspect.buttons.buildings.y, textWidth, buttonH, buttonColor, true, selection.inspect.buttons.buildings.text)
    newButton(selection.inspect.buttons.units.x, selection.inspect.buttons.units.y, textWidth, buttonH, buttonColor, true, selection.inspect.buttons.units.text)
    newButton(selection.inspect.buttons.ressources.x, selection.inspect.buttons.ressources.y, textWidth, buttonH, buttonColor, true, selection.inspect.buttons.ressources.text)

    if selection.inspect.activeMenu == "ressources" then
        drawRessourcesMenu(
            citiesList, 
            selection.inspect.x, 
            selection.inspect.y, 
            selection.inspect.width, 
            panelHeight
        )
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return selection