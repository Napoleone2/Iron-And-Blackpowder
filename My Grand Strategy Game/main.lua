-- main.lua
require("map_scrolling")
require("cities")
require("gui")
require("mui")
local Provinces = require("provinces")
local country_select = require("country_select")

function love.load()
    gamestate = "menu" 
    
    gui.load()
    mui.load()
    country_select.load()
    map.load()
end

function love.update(dt)
    if gamestate == "game" then
        map.update(dt) 
        gui.update(dt)
        cities.update(dt)
    elseif gamestate == "menu" then
        mui.update()
    elseif gamestate == "country_select" then
        country_select.update(dt)
    end

end

function love.draw()
    if gamestate == "game" then
        map.draw()
        cities.draw()
        gui.draw()
    elseif gamestate == "menu" then
        mui.draw()
    elseif gamestate == "country_select" then
        country_select.draw()
    end

end