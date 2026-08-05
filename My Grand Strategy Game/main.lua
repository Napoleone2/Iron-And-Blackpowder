-- main.lua

-- TODO: Make a document explaining the economy system
-- TODO: Make a release and share it on the discord

require("map_scrolling")
require("cities")
require("gui")
require("mui")
require("loadingscreen")
require("time")
require("music")
local Provinces = require("provinces")
local country_select = require("country_select")

function love.load()
    gamestate = "initialloading" 
    loadtime()
    
    mui.load()
    country_select.load()
    gui.load()
    map.load()
    load()
    music.load()
end

function love.update(dt)
    timemgr()
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

    music.play()
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