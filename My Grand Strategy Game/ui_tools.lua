ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

windwchunk = ww / 20
windhchunk = wh / 20

colors = {}
colors.lightest = {255/255, 228/255, 181/255}
colors.light = {235/255, 208/255, 161/255}
colors.dark = {205/255, 178/255, 131/255}
colors.darkest = {135/255, 108/255, 61/255}

function newButton(x, y, width, height, color, isHovered, text)
    local mousex, mousey = love.mouse.getPosition() 

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

function newTextLabel(x, y, width, color, ...)
    -- Combine all content arguments into a single string separated by spaces
    local textArgs = {...}
    for i = 1, #textArgs do
        textArgs[i] = tostring(textArgs[i])
    end
    local content = table.concat(textArgs, " ")

    -- Get font line count to calculate required label height
    local font = love.graphics.getFont()
    local _, lines = font:getWrap(content, width)
    local padding = 6
    local height = (#lines * font:getHeight()) + (padding * 2)

    -- Draw background rectangle
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, width, height)

    -- Draw text inside the label (with top/bottom padding)
    love.graphics.setColor(0, 0, 0, 1) -- Black text color
    love.graphics.printf(content, x, y + padding, width, "center")

    return height -- Returns the auto-calculated height for layout positioning
end