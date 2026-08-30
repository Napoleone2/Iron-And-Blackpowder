require("ui_tools")
require("fonts")
local countries = require("countries")
local game = require("main_game")

local spain_map = love.graphics.newImage("Data/Images/Terrain.jpg")
local map = {}

local country_selection = {}
local padding = 10

local mousex, mousey = 0, 0

function country_selection.load()
    country_bar = {}
    country_bar.x = 0
    country_bar.y = 0
    country_bar.width = windwchunk * 4
    country_bar.height = windhchunk * 20

    lore_box = {}
    lore_box.x = windwchunk * 4
    lore_box.y = windhchunk * 15
    lore_box.width = windwchunk * 12
    lore_box.height = windhchunk * 5

    options_bar = {}
    options_bar.x = windwchunk * 16
    options_bar.y = 0
    options_bar.width = windwchunk * 4
    options_bar.height = windhchunk * 20

    start_button = {}
    start_button.x = options_bar.x + padding
    start_button.y = windhchunk * 16
    start_button.width = options_bar.width - (padding * 2)
    start_button.height = windhchunk

    back_button = {}
    back_button.x = options_bar.x + padding
    back_button.y = windhchunk * 18
    back_button.width = options_bar.width - (padding * 2)
    back_button.height = windhchunk    

    map.x = windwchunk * 4
    map.y = 0
    map.scalex = windwchunk * 12 / spain_map:getWidth()
    map.scaley = windhchunk * 15 / spain_map:getHeight()

    for i, country in ipairs(countries) do
        if country.id ~= "glopistan" then
            country.selected = false 
        else 
            country.selected = true 
        end
    end
end

function country_selection.update()
    
    if mousex > back_button.x and mousey > back_button.y and mousex < back_button.x + back_button.width and mousey < back_button.y + back_button.height then
        if love.mouse.isDown(1) then
            gamestate = "menu"
        end
    end

    if mousex > start_button.x and mousey > start_button.y and mousex < start_button.x + start_button.width and mousey < start_button.y + start_button.height then
        if love.mouse.isDown(1) then
            game.load()
            gamestate = "gameplay"
        end
    end
    mousex, mousey = love.mouse.getPosition()
end

function country_selection.draw()
    love.graphics.setBackgroundColor(colors.lightest)
    love.graphics.setLineWidth(2)

    love.graphics.setColor(colors.light)
    love.graphics.rectangle("fill", country_bar.x, country_bar.y, country_bar.width, country_bar.height)
    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("line", country_bar.x, country_bar.y, country_bar.width, country_bar.height)

    love.graphics.setColor(colors.light)
    love.graphics.rectangle("fill", lore_box.x, lore_box.y, lore_box.width, lore_box.height)
    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("line", lore_box.x, lore_box.y, lore_box.width, lore_box.height)

    love.graphics.setColor(colors.light)
    love.graphics.rectangle("fill", options_bar.x, options_bar.y, options_bar.width, options_bar.height)
    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("line", options_bar.x, options_bar.y, options_bar.width, options_bar.height)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(spain_map, map.x, map.y, 0, map.scalex, map.scaley)

    love.graphics.setFont(bigfont)
    newButton(start_button.x, start_button.y, start_button.width, start_button.height, colors.darkest, false, "Start")
    newButton(back_button.x, back_button.y, back_button.width, back_button.height, colors.darkest, false, "Back")

    for i, country in ipairs(countries) do
        local btnX = country_bar.x + padding
        local btnY = country_bar.y + country_bar.height * (i - 1) / #countries  + padding
        local btnW = country_bar.width - padding * 2
        local btnH = windhchunk * 2 - padding * 2

        love.graphics.setFont(itemfont)
        newButton(btnX, btnY, btnW, btnH, country.color, false, string.upper(country.id))

        if country.selected then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", btnX, btnY, btnW, btnH)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.setFont(smallfont)
            love.graphics.printf(country.lore, lore_box.x + padding, lore_box.y + padding, lore_box.width - padding * 3, "left")
        end

        if mousex >= btnX and mousex <= btnX + btnW and mousey >= btnY and mousey <= btnY + btnH and love.mouse.isDown(1) then
            for _, country in ipairs(countries) do country.selected = false end
            country.selected = true
        end
    end
end

function country_selection.mousepressed(x, y, button)
    if button == 1 then
        if gamestate == "country_selection" then
            if x > back_button.x and y > back_button.y and 
               x < back_button.x + back_button.width and 
               y < back_button.y + back_button.height then
                gamestate = "menu"
            end
        end
    end
end

return country_selection