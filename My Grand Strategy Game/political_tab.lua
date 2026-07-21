local graphics = love.graphics
local ww = graphics.getWidth()
local wh = graphics.getHeight()

politicalTab = {}
politicalTab.x = 0
politicalTab.y = wh / 20
politicalTab.width = ww / 4
politicalTab.height = wh

function drawPoliticalTab()
    graphics.rectangle("fill", politicalTab.x, politicalTab.y, politicalTab.width, politicalTab.height)
end