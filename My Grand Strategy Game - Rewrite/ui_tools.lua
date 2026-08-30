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
    local font = love.graphics.getFont()
    local fontheight = font:getHeight()
    if font ~= bigfont and font ~= itemfont then
        love.graphics.printf(text, x, y + fontheight / 2, width, "center")
    elseif font ~= itemfont then
        love.graphics.printf(text, x, y, width, "center")
    end

    if font == itemfont then
        love.graphics.printf(text, x, y + fontheight / 2, width, "right")
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function newTextLabel(x, y, width, color, ...)
    local textArgs = {...}
    for i = 1, #textArgs do
        textArgs[i] = tostring(textArgs[i])
    end
    local content = table.concat(textArgs, " ")

    local font = love.graphics.getFont()
    local _, lines = font:getWrap(content, width)
    local padding = 6
    local height = (#lines * font:getHeight()) + (padding * 2)

    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, width, height)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf(content, x, y + padding, width, "center")

    return height
end

local Button = {}
Button.__index = Button

function Button.new(x, y, width, height, color, text)
    local self = setmetatable({}, Button)
    self.x = x 
    self.y = y
    self.width = width
    self.height = height
    self.baseColor = color -- {r, g, b, a}
    self.text = text
    return self
end

function Button:isHovered()
    local mousex, mousey = love.mouse.getPosition()
    return mousex >= self.x and mousey >= self.y and mousex <= self.x + self.width and mousey <= self.y + self.height
end

function Button:draw()
    local hover = self:isHovered()

    if hover then
        love.graphics.setColor(self.baseColor[1] * 0.7, self.baseColor[2] * 0.7, self.baseColor[3] * 0.7, self.baseColor[4] or 1)
    else
        love.graphics.setColor(self.baseColor[1], self.baseColor[2], self.baseColor[3], self.baseColor[4] or 1)
    end
    
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(1, 1, 1, 1)
    local font = love.graphics.getFont()
    local textHeight = font:getHeight()
    local textY = self.y + (self.height - textHeight) / 2
    love.graphics.printf(self.text, self.x, textY, self.width, "center")
end

function Button:isClicked()
    return self:isHovered() and love.mouse.isDown(1)
end

return Button