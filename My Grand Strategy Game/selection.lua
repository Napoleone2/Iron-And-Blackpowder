require("ui_tools")
local country_buttons = require("country_buttons")
local economy_defs = require("economy_defs")

local selection = {}
local iposx, iposy

selection.inspect = {}
selection.inspect.x = 0
selection.inspect.y = windhchunk * 10
selection.inspect.width = windwchunk * 5
selection.inspect.height = windhchunk * 10

local function getPlayerFaction()
    return selectedCountry and selectedCountry.id
end

local MAX_BUILDINGS = 6

local buildingNames = {
    steel_factory      = "Steel Factory",
    recruitment_center = "Recruitment Center",
    rifle_factory      = "Rifle Factory"
}

local index, PLAYER_FACTION = country_buttons.getSelectedCountry()

local function buildBuilding(city, buildingType)
    if not city or not city.buildings then return false end

    -- Check if player owns the city
    local playerFaction = getPlayerFaction()
    if not playerFaction or city.owner ~= playerFaction then
        return false -- Cannot build in unowned cities
    end

    -- Check if the city is at max capacity
    if #city.buildings >= MAX_BUILDINGS then
        return false 
    end

    local name = buildingNames[buildingType] or buildingType
    table.insert(city.buildings, name)
    return true
end

local function getCityRenderPos(city, map, zoom)
    local z = zoom or 1
    local renderX = (map and map.x or 0) + (city.x * z)
    local renderY = (map and map.y or 0) + (city.y * z)
    return renderX, renderY
end

function selection.mousepressed(x, y, button)
    if button == 1 then
        -- 1. Check main tab buttons (Buildings, Units, Ressources)
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

        -- 2. Check construction buttons inside Buildings Menu
        if selection.inspect.activeMenu == "buildings" and selection.inspect.buildButtons then
            for _, btn in ipairs(selection.inspect.buildButtons) do
                if x >= btn.x and x <= btn.x + btn.w and y >= btn.y and y <= btn.y + btn.h then
                    buildBuilding(btn.city, btn.buildingType)
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

local function drawBuildingsMenu(citiesList, x, y, width, height, padding)
    -- Find first selected city
    local selectedCity = nil
    for _, city in ipairs(citiesList) do
        if city.selected then
            selectedCity = city
            break
        end
    end

    if not selectedCity then return end

    -- Draw Main Panel Container
    love.graphics.setColor(colors.lightest)
    love.graphics.rectangle("fill", x, y, width, height)
    
    -- Left Section Background (City Slots)
    love.graphics.setColor(colors.light)
    love.graphics.rectangle("fill", x + padding, y + padding, width / 2 - (padding * 1.5), height - (padding * 2))
    
    -- Right Section Background (Construction List)
    love.graphics.setColor(colors.dark)
    love.graphics.rectangle("fill", x + width / 2 + padding / 2, y + padding, width / 2 - (padding * 1.5), height - (padding * 2))
    
    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("line", x, y, width, height)

    -- 1. Render City Building Slots (Left Side)
    local leftX = x + padding * 2
    local leftWidth = width / 2 - padding * 3.5
    local slotHeight = windhchunk * 1.25

    for i = 1, MAX_BUILDINGS do
        local drawY = y + padding * 2 + (i - 1) * (slotHeight + padding)
        local buildingName = (selectedCity.buildings and selectedCity.buildings[i]) or "Empty Slot"

        -- Card background based on occupancy
        if selectedCity.buildings and selectedCity.buildings[i] then
            love.graphics.setColor(colors.dark)
        else
            love.graphics.setColor(colors.lightest)
        end
        love.graphics.rectangle("fill", leftX, drawY, leftWidth, slotHeight)

        -- Text label
        love.graphics.setColor(0, 0, 0, 1)
        local fontHeight = love.graphics.getFont():getHeight()
        local textY = drawY + (slotHeight - fontHeight) / 2
        love.graphics.printf(buildingName, leftX + padding, textY, leftWidth - padding * 2, "center")
    end

-- 2. Render Available Buildings for Construction (Right Side)
    selection.inspect.buildButtons = {}

    local rightX = x + width / 2 + padding * 1.5
    local rightWidth = width / 2 - padding * 3.5
    local playerFaction = getPlayerFaction()

    -- If player doesn't own the city, show a warning instead of build buttons
    if not playerFaction or selectedCity.owner ~= playerFaction then
        love.graphics.setColor(1, 0.3, 0.3, 1) -- Red tint
        love.graphics.printf("Cannot build:\nCity is not owned!", rightX, y + padding * 4, rightWidth, "center")
    elseif economy_defs and economy_defs.buildings then
        local currentY = y + padding * 2
        local btnH = windhchunk / 1.25

        for _, building in pairs(economy_defs.buildings) do
            local name = building.name or "Unknown"
            local bType = building.id or name:lower():gsub(" ", "_")

            newButton(
                rightX, 
                currentY, 
                rightWidth, 
                btnH, 
                colors.darkest, 
                false, 
                name
            )

            table.insert(selection.inspect.buildButtons, {
                x = rightX,
                y = currentY,
                w = rightWidth,
                h = btnH,
                buildingType = bType,
                city = selectedCity
            })

            currentY = currentY + btnH + padding
        end
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

    if selection.inspect.activeMenu == "buildings" then
        drawBuildingsMenu(
            citiesList,
            selection.inspect.x + selection.inspect.width,
            selection.inspect.y,
            windwchunk * 10,
            panelHeight,
            10
        )
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return selection