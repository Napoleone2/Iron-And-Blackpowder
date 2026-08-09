-- TODO: work on this

local graphics = love.graphics
local ww = graphics.getWidth()
local wh = graphics.getHeight()

economicTab = {}
economicTab.x = 0
economicTab.y = wh / 20
economicTab.width = ww / 4
economicTab.height = wh

function drawEconomicTab()
    graphics.rectangle("fill", economicTab.x, economicTab.y, economicTab.width, economicTab.height)
end