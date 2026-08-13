require("ui_tools")

-- TODO: work on this
local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

researchTab = {}
researchTab.x = 0
researchTab.y = 0
researchTab.width = windwchunk * 5
researchTab.height = windhchunk * 20

function drawResearchTab()
    newFrame(researchTab.x, researchTab.y, researchTab.width, researchTab.height, {255/255, 228/255, 181/255, 1}, "Research")
end