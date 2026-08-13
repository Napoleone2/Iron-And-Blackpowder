require("ui_tools")
require("fonts")

-- TODO: Start working on this again some day
politicalTab = {}
politicalTab.x = 0
politicalTab.y = 0
politicalTab.width = windwchunk * 5
politicalTab.height = windhchunk * 20
politicalTab.closed = true

politicalTab.close_button = {}
politicalTab.close_button.width = windwchunk
politicalTab.close_button.height = windhchunk

function drawPoliticalTab()
    if politicalTab.closed then
        return
    end

    local mousex, mousey = love.mouse.getPosition()

    -- keep close button positioned relative to the tab
    politicalTab.close_button.x = politicalTab.x + politicalTab.width - politicalTab.close_button.width
    politicalTab.close_button.y = politicalTab.y

    -- close on left-click while cursor is over the button
    if love.mouse.isDown(1) and mousex > politicalTab.close_button.x and mousey > politicalTab.close_button.y and mousex < politicalTab.close_button.x + politicalTab.close_button.width and mousey < politicalTab.close_button.y + politicalTab.close_button.height then
        politicalTab.closed = true
    end

    newFrame(politicalTab.x, politicalTab.y, politicalTab.width, politicalTab.height, {255/255, 228/255, 181/255, 1}, "Politics")
    love.graphics.setFont(bigfont)
    newButton(politicalTab.close_button.x, politicalTab.close_button.y, politicalTab.close_button.width, politicalTab.close_button.height, {193/255, 154/255, 107/255}, false, "X")
end