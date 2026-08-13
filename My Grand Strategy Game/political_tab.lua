require("ui_tools")

-- TODO: Start working on this again some day
local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

politicalTab = {}
politicalTab.x = 0
politicalTab.y = 0
politicalTab.width = windwchunk * 5
politicalTab.height = windhchunk * 20
politicalTab.closed = true

function drawPoliticalTab()
    newFrame(politicalTab.x, politicalTab.y, politicalTab.width, politicalTab.height, {255/255, 228/255, 181/255, 1}, "Politics")
    newButton(politicalTab.width - windwchunk, politicalTab.y, windwchunk, windhchunk, {193/255, 154/255, 107/255}, false, "X")
end