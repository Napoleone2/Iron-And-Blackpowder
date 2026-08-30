local city_data = require("city_data")
local countries = require("countries")
local Button = require("ui_tools")
local time = require("time")
require("fonts")

local game = {}
local padding = 15
local zoom = 1
local move_speed = 300

local country_lookup = {}
for _, country in ipairs(countries) do
    country_lookup[country.id] = country
end
local cities = {}

function game.load()
    for _, country in ipairs(countries) do
        if country.selected then
            selected_country_flag = country.flag
        end
    end
    game.map = {
        image = love.graphics.newImage("Data/Images/spain_map.png"),
        x = 1,
        y = 1,
        width = 0,
        height = 0,
        frame = { x = 1, y = 1, width = 1, height = 1 }
    }

    game.gui = {}

    game.gui.topbar = {
        x = 0,
        y = 0,
        width = windwchunk * 20,
        height = windhchunk 
    }

    game.gui.flag = {
        x = 0 + padding,
        y = 0 + padding,
        image = love.graphics.newImage(selected_country_flag),
    }

    game.gui.flag.width = game.gui.flag.image:getWidth()
    game.gui.flag.height = game.gui.flag.image:getHeight()
    game.gui.flag.scalex = windwchunk * 3 / game.gui.flag.width
    game.gui.flag.scaley = windhchunk * 3.5 / game.gui.flag.height

end

function cities.draw()
    for _, city in ipairs(city_data) do
        local color = {0, 0, 0}
        if city.controller ~= "none" and country_lookup[city.controller] then
            color = country_lookup[city.controller].color
        end

        local screenX = city.pctX * game.map.width + game.map.x
        local screenY = city.pctY * game.map.height + game.map.y

        -- Selection outer ring
        if city.selected then
            love.graphics.setColor(0.5, 1, 0.5)
        else
            love.graphics.setColor(0, 0, 0)
        end
        love.graphics.circle("fill", screenX, screenY, 7)

        -- Inner city marker
        love.graphics.setColor(color)
        love.graphics.circle("fill", screenX, screenY, 5)
    end
end

function game.update(dt)
    dt = dt or 0.016

    game.map.width = game.map.image:getWidth() * zoom
    game.map.height = game.map.image:getHeight() * zoom

    game.map.frame.width = game.map.width + padding * 2 
    game.map.frame.height = game.map.height + padding * 2
    game.map.frame.x = game.map.x - padding
    game.map.frame.y = game.map.y - padding

    if love.keyboard.isScancodeDown("w") then game.map.y = game.map.y + move_speed * dt end
    if love.keyboard.isScancodeDown("s") then game.map.y = game.map.y - move_speed * dt end
    if love.keyboard.isScancodeDown("a") then game.map.x = game.map.x + move_speed * dt end
    if love.keyboard.isScancodeDown("d") then game.map.x = game.map.x - move_speed * dt end
end

function game.draw()
    love.graphics.setBackgroundColor(205 / 255, 133 / 255, 63 / 255)

    love.graphics.setColor(22 / 111, 22 / 111, 22 / 111)
    love.graphics.rectangle("fill", game.map.frame.x, game.map.frame.y, game.map.frame.width, game.map.frame.height)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(game.map.image, game.map.x, game.map.y, 0, zoom, zoom)

    cities.draw()

    love.graphics.setColor(colors.lightest)
    love.graphics.rectangle(
        "fill",
        game.gui.topbar.x, 
        game.gui.topbar.y, 
        game.gui.topbar.width, 
        game.gui.topbar.height
    )

    love.graphics.rectangle(
        "fill",
        game.gui.flag.x - padding, 
        game.gui.flag.y - padding, 
        game.gui.flag.width * game.gui.flag.scalex + padding * 2, 
        game.gui.flag.height * game.gui.flag.scaley + padding * 2
    )

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        game.gui.flag.image,
        game.gui.flag.x,
        game.gui.flag.y,
        0,
        game.gui.flag.scalex,
        game.gui.flag.scaley
    )

    if game.button1 then
        game.button1:draw()
    end
    if time.date then
        love.graphics.setFont(bigfont)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(time.tick, 0, 0, windwchunk * 20, "right")
    end
end

function game.keypressed(key)
    time.keypressed(key)
end

function game.wheelmoved(x, y)
    zoom = math.max(0.1, math.min(5.0, zoom + y * 0.05))
end

return game