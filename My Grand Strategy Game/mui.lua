require("button")

mui = {}
ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

mousex, mousey = love.mouse.getPosition()

function mui.load()
    Bigfont = love.graphics.newFont("Data/Reblade-Regular.otf", 40)

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
    playbutton.color = {193/255, 154/255, 107/255}

    qtw = {}
    qtw.x = sidebar.x
    qtw.y = sidebar.height / 2
    qtw.width = sidebar.width
    qtw.height = sidebar.height/18
    qtw.color = {193/255, 154/255, 107/255}
end

function mui.update()
    mousex, mousey = love.mouse.getPosition()
    
    local playbuttonHovered = mousex > playbutton.x and mousex < playbutton.x + playbutton.width and mousey > playbutton.y and mousey < playbutton.y + playbutton.height
    local qtwHovered = mousex > qtw.x and mousex < qtw.x + qtw.width and mousey > qtw.y and mousey < qtw.y + qtw.height
    
    if playbuttonHovered and love.mouse.isDown(1) then
        gamestate = "country_select"
    end
    
    if qtwHovered and love.mouse.isDown(1) then
        love.event.quit()
    end
end

function mui.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(wp1, 0, 0, 0, ww / wp1w, ww / wp1h)

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", sidebar.x, sidebar.y, sidebar.width, sidebar.height)

    local playbuttonHovered = mousex > playbutton.x and mousex < playbutton.x + playbutton.width and mousey > playbutton.y and mousey < playbutton.y + playbutton.height
    local qtwHovered = mousex > qtw.x and mousex < qtw.x + qtw.width and mousey > qtw.y and mousey < qtw.y + qtw.height
    
    newButton(playbutton.x, playbutton.y, playbutton.width, playbutton.height, playbutton.color, playbuttonHovered, "New Game")
    newButton(qtw.x, qtw.y, qtw.width, qtw.height, qtw.color, qtwHovered, "Quit Game")

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(Bigfont)
    love.graphics.printf("Iron and Blackpowder", sidebar.x, sidebar.height / 4, sidebar.width, "justify")
end