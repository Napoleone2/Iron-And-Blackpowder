require("ui_tools")
require("fonts")
local city_data = require("city_data")
local countries = require("countries")

function getGlobalStats(citiesList, countriesList, playerSelection)
    -- Extract the string ID if a country table was passed
    local factionId = type(playerSelection) == "table" and playerSelection.id or playerSelection
    local targetId = factionId and string.lower(tostring(factionId)) or nil

    local stats = {
        total_cities = 0,
        total_population = 0,
        total_tax_income = 0,
        treasury = 0
    }

    -- 1. Calculate City Stats
    if citiesList then
        for _, city in ipairs(citiesList) do
            local owner = city.owner and string.lower(tostring(city.owner))
            local controller = city.controller and string.lower(tostring(city.controller))

            -- Match if no faction specified, or if owner/controller matches player faction ID
            if not targetId or owner == targetId or controller == targetId then
                stats.total_cities = stats.total_cities + 1
                stats.total_population = stats.total_population + (city.population or 0)
                
                local income = (city.tax_income and city.tax_income > 0) 
                    and city.tax_income 
                    or math.floor((city.population or 0) * 0.00001)
                
                stats.total_tax_income = stats.total_tax_income + income
            end
        end
    end

    -- 2. Calculate Treasury
    if countriesList then
        for _, country in ipairs(countriesList) do
            local cId = country.id and string.lower(tostring(country.id))
            if not targetId then
                stats.treasury = stats.treasury + (country.treasury or 0)
            elseif cId == targetId then
                stats.treasury = country.treasury or 0
                break
            end
        end
    end

    return stats
end

economyTab = {}
economyTab.x = 0
economyTab.y = 0
economyTab.width = windwchunk * 5
economyTab.height = windhchunk * 20
economyTab.closed = true

economyTab.close_button = {}
economyTab.close_button.width = windwchunk
economyTab.close_button.height = windhchunk

function drawEconomicTab(globalStats)
    if economyTab.closed then
        return
    end

    local mousex, mousey = love.mouse.getPosition()

    economyTab.close_button.x = economyTab.x + economyTab.width - economyTab.close_button.width
    economyTab.close_button.y = economyTab.y

    if love.mouse.isDown(1) and mousex > economyTab.close_button.x and mousey > economyTab.close_button.y and mousex < economyTab.close_button.x + economyTab.close_button.width and mousey < economyTab.close_button.y + economyTab.close_button.height then
        economyTab.closed = true
    end

    newFrame(economyTab.x, economyTab.y, economyTab.width, economyTab.height, colors.lightest, "Economy")
    love.graphics.setFont(bigfont)
    newButton(economyTab.close_button.x, economyTab.close_button.y, economyTab.close_button.width, economyTab.close_button.height, colors.darkest, false, "X")

    -- Global Stats Section
    local stats = globalStats or {}
    local padding = 15
    local lineSpacing = 28
    local startY = economyTab.y + windhchunk * 2
    local statBoxHeight = lineSpacing * 5.5 + padding

    love.graphics.setColor(colors.dark)
    love.graphics.rectangle("fill", economyTab.x + padding / 2, startY - padding / 2, economyTab.width - padding, statBoxHeight)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(mediumfont or bigfont)

    love.graphics.printf("Global Overview", economyTab.x, startY, economyTab.width, "center")
    startY = startY + lineSpacing * 1.5

    love.graphics.printf("Total Cities: " .. (stats.total_cities or 0), economyTab.x + padding, startY, economyTab.width - padding * 2, "left")
    startY = startY + lineSpacing

    love.graphics.printf("Total Population: " .. (stats.total_population or 0), economyTab.x + padding, startY, economyTab.width - padding * 2, "left")
    startY = startY + lineSpacing

    love.graphics.printf("Total Tax Income: " .. (stats.total_tax_income or 0), economyTab.x + padding, startY, economyTab.width - padding * 2, "left")
    startY = startY + lineSpacing

    love.graphics.printf("Treasury: " .. (stats.treasury or 0), economyTab.x + padding, startY, economyTab.width - padding * 2, "left")

    love.graphics.setColor(1, 1, 1, 1)
end

