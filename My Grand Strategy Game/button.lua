function newButton(x, y, width, height, color, isHovered, text)
    local displayColor = {color[1], color[2], color[3], color[4] or 1}
    if isHovered then
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