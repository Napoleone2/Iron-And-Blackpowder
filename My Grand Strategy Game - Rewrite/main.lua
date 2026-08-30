local mui = require("mui")
local music = require("music")
local country_selection = require("country_selection")
local game = require("main_game")

gamestate = "menu"

function love.load()
    music.load()
    mui.load()
    country_selection.load()
    game.load()
end

function love.update(dt)
    music.play()
    if gamestate == "menu" then
        mui.update()
    elseif gamestate == "country_selection" then
        country_selection.update()
    elseif gamestate == "gameplay" then
        game.update()
    end
end

function love.draw()
    if gamestate == "menu" then
        mui.draw()
    elseif gamestate == "country_selection" then
        country_selection.draw()
    elseif gamestate == "gameplay" then
        game.draw()
    end
    love.graphics.setColor(0, 0, 0, 1)
end

function love.mousepressed(x, y, button)
    if gamestate == "country_selection" then
        country_selection.mousepressed(x, y, button)
    end
end

function love.keypressed(key)
    game.keypressed(key)
end

function love.wheelmoved(x, y)
    game.wheelmoved(x, y)
end