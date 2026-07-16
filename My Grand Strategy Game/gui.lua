require("time")
require("country_select")
require("country_buttons")
ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

gui = {}

function gui.load()
    topbar = {}
    topbar.x = 0
    topbar.y = 0
    topbar.width = ww
    topbar.height = wh / 20

    flag = {}
    flag.x = topbar.x
    flag.y = topbar.y

    
    gui.smallFont = love.graphics.newFont("Data/Reblade-Regular.otf", 35)
end

function gui.update()

end

function gui.draw()
    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(gui.smallFont)
    love.graphics.printf("Day:" .. days .. " | " .. paused .. " | Speed: " .. time_speed, 0, 0, topbar.width, "right")
end