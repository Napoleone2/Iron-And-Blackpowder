ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

gui = {}

function gui.load()
    topbar = {}
    topbar.x = 0
    topbar.y = 0
    topbar.width = ww
    topbar.height = wh / 20

    bottom_menu = {}
    bottom_menu.x = ww
    bottom_menu.y = wh
    bottom_menu.width = -(ww / 5)
    bottom_menu.height = -(wh / 4)
    
    gui.smallFont = love.graphics.newFont("Data/Reblade-Regular.otf", 16)
end

function gui.update()

end

function gui.draw()

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)

    love.graphics.rectangle("fill", bottom_menu.x, bottom_menu.y, bottom_menu.width, bottom_menu.height)
end