require("ui_tools")
require("fonts")
local country_selection = require("country_selection")

local mui = {}
local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()
local version = "Version 0.1.0 (DEV)"

local mousex, mousey = love.mouse.getPosition()

function mui.load()

    wp1 = love.graphics.newImage("Data/Images/wp1.jpg")
    wp1w = wp1:getWidth()
    wp1h = wp1:getHeight()

    sidebar = {}
    sidebar.x = 0
    sidebar.y = 0
    sidebar.width = ww / 4
    sidebar.height = wh

    playbutton = {}
    playbutton.x = sidebar.x
    playbutton.y = sidebar.height/2.5
    playbutton.width = sidebar.width
    playbutton.height = sidebar.height/18

    qtw = {}
    qtw.x = sidebar.x
    qtw.y = sidebar.height / 2
    qtw.width = sidebar.width
    qtw.height = sidebar.height/18

    version_frame = {}
    version_frame.x = sidebar.x
    version_frame.y = wh
    version_frame.width = sidebar.width
    version_frame.height = -windhchunk
end

function mui.update()
    mousex, mousey = love.mouse.getPosition()
    
    local playbuttonHovered = mousex > playbutton.x and mousex < playbutton.x + playbutton.width and mousey > playbutton.y and mousey < playbutton.y + playbutton.height
    local qtwHovered = mousex > qtw.x and mousex < qtw.x + qtw.width and mousey > qtw.y and mousey < qtw.y + qtw.height
    
    if playbuttonHovered and love.mouse.isDown(1) then
        country_selection.load()
        gamestate = "country_selection"
    end
    
    if qtwHovered and love.mouse.isDown(1) then
        love.event.quit()
    end
end

function mui.draw()
    love.graphics.setFont(bigfont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(wp1, 0, 0, 0, ww / wp1w, ww / wp1h)

    love.graphics.setColor(colors.lightest)
    love.graphics.rectangle("fill", sidebar.x, sidebar.y, sidebar.width, sidebar.height)

    local playbuttonHovered = mousex > playbutton.x and mousex < playbutton.x + playbutton.width and mousey > playbutton.y and mousey < playbutton.y + playbutton.height
    local qtwHovered = mousex > qtw.x and mousex < qtw.x + qtw.width and mousey > qtw.y and mousey < qtw.y + qtw.height
    
    newButton(playbutton.x, playbutton.y, playbutton.width, playbutton.height, colors.darkest, playbuttonHovered, "New Game")
    newButton(qtw.x, qtw.y, qtw.width, qtw.height, colors.darkest, qtwHovered, "Quit Game")

    love.graphics.setColor(colors.darkest)
    love.graphics.rectangle("fill", version_frame.x, version_frame.y, version_frame.width, version_frame.height)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(bigfont)
    love.graphics.printf("Iron and Blackpowder", sidebar.x, sidebar.height / 4, sidebar.width, "justify")
    love.graphics.setFont(bigfont)
    love.graphics.printf(version, version_frame.x, version_frame.y + version_frame.height, version_frame.width, "center")

end

return mui