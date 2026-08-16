require("time")
local country_Select = require("country_select")
require("country_buttons")
local countries = require("countries") -- Fixed case-sensitivity matching countries.lua[cite: 7, 10]
require("ui_tools")
require("political_tab")
require("economy_tab")
require("research_tab")
require("hovered")
require("fonts")
local city_data = { list = require("city_data") }
local selection = require("selection")

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

gui = {}

local prevLeftDown = false

local function drawCountryFlag()
    if gui.flag.image and selectedCountry then
        local targetHeight = 96
        local scaleX = targetHeight / math.max(1, gui.flag.image:getHeight())
        local scaleY = targetHeight / math.max(1, gui.flag.image:getHeight())
        local drawWidth = gui.flag.image:getWidth() * scaleX
        local drawHeight = gui.flag.image:getHeight() * scaleY

        love.graphics.setColor(255/255, 228/255, 181/255)
        love.graphics.setLineWidth((ww or love.graphics.getWidth()) / 80)
        love.graphics.rectangle("line", gui.flag.x, gui.flag.y, drawWidth, drawHeight)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(gui.flag.image, gui.flag.x, gui.flag.y, 0, scaleX, scaleY)
    end
end

function gui.processDailyIncome()
    local cityList = (cities and cities.list) or city_data.list

    -- 1. Update daily tax income per city with a balanced multiplier[cite: 10]
    for _, city in ipairs(cityList) do
        local tax_income_modifier = 0.00001 -- Reduced from 0.0001 to prevent hyper-inflation[cite: 10]
        city.tax_income = math.floor((city.population or 0) * tax_income_modifier)
    end

    -- 2. Add tax income to country treasuries once per daily tick[cite: 10]
    for _, country in ipairs(countries) do
        for _, city in ipairs(cityList) do
            if city.controller == country.id then
                country.treasury = (country.treasury or 0) + city.tax_income
            end
        end
    end
end

function gui.load()
    currenttab = "none"

    topbar = {}
    topbar.x = 0
    topbar.y = 0
    topbar.width = ww
    topbar.height = wh / 20

    gui.flag = {}
    gui.flag.x = 6
    gui.flag.y = 6
    gui.flag.padding = 6
    gui.flag.image = nil
    gui.flag.path = nil
    gui.flagScale = 1

    gui.button_political = {}
    gui.button_political.x = ww / 8
    gui.button_political.y = topbar.height
    gui.button_political.width = 200
    gui.button_political.height = 25
    gui.button_political.color = {0.2, 0.2, 0.8, 1}
    gui.button_political.text = "Political"

    gui.button_economy = {}
    gui.button_economy.x = gui.button_political.x + gui.button_political.width
    gui.button_economy.y = topbar.height
    gui.button_economy.width = 200
    gui.button_economy.height = 25
    gui.button_economy.color = {0.2, 0.8, 0.2, 1}
    gui.button_economy.text = "Economy"

    gui.button_research = {}
    gui.button_research.x = gui.button_economy.x + gui.button_economy.width
    gui.button_research.y = topbar.height
    gui.button_research.width = 200
    gui.button_research.height = 25
    gui.button_research.color = {0.8, 0.2, 0.2, 1}
    gui.button_research.text = "Research"
end

function gui.update()
    if selectedCountry and selectedCountry.flag and selectedCountry.flag ~= gui.flag.path then
        gui.flag.path = selectedCountry.flag
        local ok, image = pcall(love.graphics.newImage, selectedCountry.flag)
        gui.flag.image = (ok and image) or nil
    elseif not selectedCountry and gui.flag.path then
        gui.flag.path = nil
        gui.flag.image = nil
    end

    local mousex, mousey = love.mouse.getPosition()

    gui.button_political.isHovered = mousex > gui.button_political.x and mousex < gui.button_political.x + gui.button_political.width and mousey > gui.button_political.y and mousey < gui.button_political.y + gui.button_political.height
    gui.button_economy.isHovered = mousex > gui.button_economy.x and mousex < gui.button_economy.x + gui.button_economy.width and mousey > gui.button_economy.y and mousey < gui.button_economy.y + gui.button_economy.height
    gui.button_research.isHovered = mousex > gui.button_research.x and mousex < gui.button_research.x + gui.button_research.width and mousey > gui.button_research.y and mousey < gui.button_research.y + gui.button_research.height

    local leftDown = love.mouse.isDown(1)
    local leftClicked = leftDown and not prevLeftDown

    if leftClicked then
        if gui.button_political.isHovered and politicalTab.closed then
            currenttab = "political"
            politicalTab.closed = false
        elseif gui.button_economy.isHovered and economyTab.closed then
            currenttab = "economic"
            economyTab.closed = false
        elseif gui.button_research.isHovered and researchTab.closed then
            currenttab = "research"
            researchTab.closed = false
        end
    end

    prevLeftDown = leftDown
end

function gui.draw()
    selection.draw()

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)

    love.graphics.setFont(mediumfont)
    drawCountryFlag()

    newButton(gui.button_political.x, gui.button_political.y, gui.button_political.width, gui.button_political.height, gui.button_political.color, gui.button_political.isHovered, gui.button_political.text)
    newButton(gui.button_economy.x, gui.button_economy.y, gui.button_economy.width, gui.button_economy.height, gui.button_economy.color, gui.button_economy.isHovered, gui.button_economy.text)
    newButton(gui.button_research.x, gui.button_research.y, gui.button_research.width, gui.button_research.height, gui.button_research.color, gui.button_research.isHovered, gui.button_research.text)

    if selectedCountry then
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(bigfont)

    -- 1. Find the live country record from the countries table
    local currentCountry = nil
    for _, country in ipairs(countries) do
        if country.id == selectedCountry.id then
            currentCountry = country
            break
        end
    end

    -- Fallback to selectedCountry if not found
    currentCountry = currentCountry or selectedCountry

    -- 2. Calculate population from controlled cities
    local cityList = (cities and cities.list) or city_data.list
    local totalPopulation = 0
    if cityList and currentCountry.id then
        for _, city in ipairs(cityList) do
            if city.controller == currentCountry.id then
                totalPopulation = totalPopulation + (city.population or 0)
            end
        end
    end

    -- 3. Display live treasury value (unfrozen)
    local treasuryX = gui.button_political.x
    local treasuryY = 0
    local liveTreasury = math.floor(currentCountry.treasury or 0)
    if liveTreasury < 1000000 then 
        treasuryText = "Treasury: $" .. math.floor(liveTreasury / 1000) .. "K"
    else
        treasuryText = "Treasury: $" .. math.floor(liveTreasury / 1000000) .. "M"
    end
    -- 4. Format population display
    local popText = ""
    if totalPopulation >= 1000000 then
        popText = string.format(" | Pop: %.1fM", totalPopulation / 1000000)
    elseif totalPopulation >= 1000 then
        popText = string.format(" | Pop: %dK", math.floor(totalPopulation / 1000))
    else
        popText = " | Pop: " .. totalPopulation
    end

    love.graphics.print(treasuryText .. popText, treasuryX, treasuryY)
end

    if currenttab == "political" then
        drawPoliticalTab()
    elseif currenttab == "economic" then
        -- Passed city_data.list array directly so ipairs doesn't fail
        local globalStats = getGlobalStats(city_data.list, countries, selectedCountry)
        drawEconomicTab(globalStats)
    elseif currenttab == "research" then
        drawResearchTab()
    end

    local cityList = (cities and cities.list) or city_data.list
    if cityList then
        selection.inspect.draw(cityList)
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(bigfont)
    love.graphics.printf(date, 0, 0, topbar.width, "right")
end