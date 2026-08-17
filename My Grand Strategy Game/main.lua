-- TODO: Make a document explaining the economy system [33%]
-- TODO: Make a release and share it on the discord [0.0.3]

require("map_scrolling")
require("cities")
require("gui")
require("mui")
require("loadingscreen")
require("time")
require("music")
local Provinces = require("provinces")
local country_select = require("country_select")
local selection = require("selection")

function love.mousepressed(x, y, button)
    if gamestate == "game" then
        selection.mousepressed(x, y, button)
    end
end

function love.mousereleased(x, y, button)
    if gamestate == "game" then
        selection.mousereleased(x, y, button, cities.list, map, zoom)
    end
end

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
    elseif gamestate == "maingameloading" then
        drawload()
    elseif gamestate == "game" then
        map.draw()
        cities.draw()
        gui.draw() 
    elseif gamestate == "menu" then
        mui.draw()
    elseif gamestate == "country_select" then
        country_select.draw()
    end
end