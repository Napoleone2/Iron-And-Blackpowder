-- main.lua
require("map_scrolling")
require("cities")
require("gui")
require("mui")
require("loadingscreen")
local Provinces = require("provinces")
local country_select = require("country_select")

function love.load()
    gamestate = "initialloading" 
    
    gui.load()
    mui.load()
    country_select.load()
    map.load()
    load()
end

function love.update(dt)
    if gamestate == "initialloading" then
        loadupdate(2)
    end
    if gamestate == "maingameloading" then
        loadupdate(1)
    end

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
    if gamestate == "initialloading" then
        drawload()
    end
    if gamestate == "maingameloading" then
        drawload()
    end
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