local Provinces = require("provinces")

map = {}

function map.load()
    zoom = 2
    scroll_speed = 5

    map.image = love.graphics.newImage("Data/Images/spain_map.png")
    map.terrain = love.graphics.newImage("Data/Images/Terrain.jpg")

    map.Terrain = {}
    map.Terrain.height = map.terrain:getHeight()
    map.Terrain.width = map.terrain:getWidth()

    map.width = map.image:getWidth()
    map.height = map.image:getHeight()

    map.x = 0
    map.y = 0

    if cities and cities.load then
        cities.load()
    end

    Provinces.generate(map.width, map.height, cities.list)
end

function map.update()
    if love.keyboard.isDown("up") then
        map.y = map.y + scroll_speed
    end

    if love.keyboard.isDown("down") then
        map.y = map.y - scroll_speed
    end

    if love.keyboard.isDown("left") then
        map.x = map.x + scroll_speed
     end

    
    if love.keyboard.isDown("right") then
        map.x = map.x - scroll_speed
    end
end

function love.wheelmoved(x, y)
    zoom = math.max(0.1, zoom + y * 0.1)
end

function map.draw()
    
    love.graphics.setColor(205 / 255, 133 / 255, 63 / 255, 1)
    love.graphics.rectangle("fill", -100000, -100000, 10000000, 10000000)
    
    love.graphics.setColor(102 / 255, 76 / 255 , 40 / 255)
    love.graphics.rectangle("fill", 
        map.x - map.width * zoom / 20,   
        map.y - map.height * zoom / 20,   
        map.width * zoom + map.width * zoom / 10,   
        map.height * zoom + map.height * zoom / 10
    )

    love.graphics.setColor(1, 1, 1, 1)
    local terrainScaleX = (map.width / map.Terrain.width) * zoom
    local terrainScaleY = (map.height / map.Terrain.height) * zoom
    love.graphics.draw(map.terrain, map.x, map.y, 0, terrainScaleX, terrainScaleY)

    
    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1, 1, 1, 1)
    
    if Provinces.canvas then
        love.graphics.draw(Provinces.canvas, map.x, map.y, 0, zoom, zoom)
    end
    
    
    love.graphics.setBlendMode("alpha")

    love.graphics.setColor(1, 1, 1, 0) 
    love.graphics.draw(map.image, map.x, map.y, 0, zoom, zoom)
    
    love.graphics.setColor(1, 1, 1, 1) -- Reset default
end