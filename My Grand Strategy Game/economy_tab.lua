require("ui_tools")
require("fonts")

-- TODO: Start working on this again some day
economyTab = {}
economyTab.x = 0
economyTab.y = 0
economyTab.width = windwchunk * 5
economyTab.height = windhchunk * 20
economyTab.closed = true

economyTab.close_button = {}
economyTab.close_button.width = windwchunk
economyTab.close_button.height = windhchunk

function drawEconomicTab()
    if economyTab.closed then
        return
    end

    local mousex, mousey = love.mouse.getPosition()

    economyTab.close_button.x = economyTab.x + economyTab.width - economyTab.close_button.width
    economyTab.close_button.y = economyTab.y

    if love.mouse.isDown(1) and mousex > economyTab.close_button.x and mousey > economyTab.close_button.y and mousex < economyTab.close_button.x + economyTab.close_button.width and mousey < economyTab.close_button.y + economyTab.close_button.height then
        economyTab.closed = true
    end

    newFrame(economyTab.x, economyTab.y, economyTab.width, economyTab.height, {255/255, 228/255, 181/255, 1}, "Economy")
    love.graphics.setFont(bigfont)
    newButton(economyTab.close_button.x, economyTab.close_button.y, economyTab.close_button.width, economyTab.close_button.height, {193/255, 154/255, 107/255}, false, "X")
end