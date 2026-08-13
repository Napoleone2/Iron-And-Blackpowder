require("ui_tools")

-- TODO: work on this
local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

economicTab = {}
economicTab.x = 0
economicTab.y = 0
economicTab.width = windwchunk * 5
economicTab.height = windhchunk * 20

function drawEconomicTab()
    newFrame(economicTab.x, economicTab.y, economicTab.width, economicTab.height, {255/255, 228/255, 181/255, 1}, "Economy")
end