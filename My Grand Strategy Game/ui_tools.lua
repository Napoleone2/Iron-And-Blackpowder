ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

windwchunk = ww / 20
windhchunk = wh / 20

function newButton(x, y, width, height, color, isHovered, text)
    mousex, mousey = love.mouse.getPosition()

    local displayColor = {color[1], color[2], color[3], color[4] or 1}
    if mousex > x and mousey > y and mousex < x + width and mousey < y + height then
        displayColor[1] = displayColor[1] * 0.7
        displayColor[2] = displayColor[2] * 0.7
        displayColor[3] = displayColor[3] * 0.7
    end
    
    love.graphics.setColor(displayColor[1], displayColor[2], displayColor[3], displayColor[4])
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf(text, x, y, width, "center")
    love.graphics.setColor(1, 1, 1, 1)
end

function newFrame(x, y, width, height, color, name)
    love.graphics.setColor(color[1], color[2], color[3], color[4] or 1)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0, 0, 0, 1)
    if name then
        love.graphics.print(name, x, y)
    else
        love.graphics.print("Untitled", x, y)
    end
end

