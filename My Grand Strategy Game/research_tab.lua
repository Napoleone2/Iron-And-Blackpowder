require("ui_tools")
require("fonts")

-- TODO: Start working on this again some day
researchTab = {}
researchTab.x = 0
researchTab.y = 0
researchTab.width = windwchunk * 5
researchTab.height = windhchunk * 20
researchTab.closed = true

researchTab.close_button = {}
researchTab.close_button.width = windwchunk
researchTab.close_button.height = windhchunk

function drawResearchTab()
    if researchTab.closed then
        return
    end

    local mousex, mousey = love.mouse.getPosition()

    researchTab.close_button.x = researchTab.x + researchTab.width - researchTab.close_button.width
    researchTab.close_button.y = researchTab.y

    if love.mouse.isDown(1) and mousex > researchTab.close_button.x and mousey > researchTab.close_button.y and mousex < researchTab.close_button.x + researchTab.close_button.width and mousey < researchTab.close_button.y + researchTab.close_button.height then
        researchTab.closed = true
    end

    newFrame(researchTab.x, researchTab.y, researchTab.width, researchTab.height, {255/255, 228/255, 181/255, 1}, "Research")
    love.graphics.setFont(bigfont)
    newButton(researchTab.close_button.x, researchTab.close_button.y, researchTab.close_button.width, researchTab.close_button.height, {193/255, 154/255, 107/255}, false, "X")
end