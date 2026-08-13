require("time")
require("country_select")
require("country_buttons")
local countries = require("Countries")
require("ui_tools")
require("political_tab")
require("economy_tab")
require("research_tab")
require("hovered")
require("fonts")

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

gui = {}

-- Initialize the top bar and UI flag state.
function gui.load()
    currenttab = "none"

    topbar = {}
    topbar.x = 0
    topbar.y = 0
    topbar.width = ww
    topbar.height = wh / 20

    gui.flag = {}
    gui.flag.x = 6
    gui.flag.y = 6
    gui.flag.padding = 6
    gui.flag.image = nil
    gui.flag.path = nil
    gui.flagScale = 1


    gui.button_political = {}
    gui.button_political.x = ww / 8
    gui.button_political.y = topbar.height
    gui.button_political.width = 200
    gui.button_political.height = 25
    gui.button_political.color = {0.2, 0.2, 0.8, 1}
    gui.button_political.text = "Political"

    gui.button_economy = {}
    gui.button_economy.x = gui.button_political.x + gui.button_political.width
    gui.button_economy.y = topbar.height
    gui.button_economy.width = 200
    gui.button_economy.height = 25
    gui.button_economy.color = {0.2, 0.8, 0.2, 1}
    gui.button_economy.text = "Economy"

    gui.button_research = {}
    gui.button_research.x = gui.button_economy.x + gui.button_economy.width
    gui.button_research.y = topbar.height
    gui.button_research.width = 200
    gui.button_research.height = 25
    gui.button_research.color = {0.8, 0.2, 0.2, 1}
    gui.button_research.text = "Research"

end



function gui.update()
    -- Reload the flag image whenever the selected country changes.
    if selectedCountry and selectedCountry.flag and selectedCountry.flag ~= gui.flag.path then
        gui.flag.path = selectedCountry.flag
        local ok, image = pcall(love.graphics.newImage, selectedCountry.flag)
        if ok and image then
            gui.flag.image = image
        else
            gui.flag.image = nil
        end
    elseif not selectedCountry and gui.flag.path then
        gui.flag.path = nil
        gui.flag.image = nil
    end

    function drawCountryFlag()
        if gui.flag.image and selectedCountry then
            targetHeight = 96
            scaleX = targetHeight / math.max(1, gui.flag.image:getHeight())
            scaleY = targetHeight / math.max(1, gui.flag.image:getHeight())
            drawWidth = gui.flag.image:getWidth() * scaleX
            drawHeight = gui.flag.image:getHeight() * scaleY

            love.graphics.setColor(255/255, 228/255, 181/255)
            love.graphics.setLineWidth(ww / 80)
            love.graphics.rectangle("line", gui.flag.x, gui.flag.y, drawWidth, drawHeight)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(gui.flag.image, gui.flag.x, gui.flag.y, 0, scaleX, scaleY)

        end

    end
    drawCountryFlag()

    mousex, mousey = love.mouse.getPosition()

    if mousex > gui.button_political.x and mousex < gui.button_political.x + gui.button_political.width and mousey > gui.button_political.y and mousey < gui.button_political.y + gui.button_political.height then
        if love.mouse.isDown(1) then
            currenttab = "political"
        end
    end

    if mousex > gui.button_economy.x and mousex < gui.button_economy.x + gui.button_economy.width and mousey > gui.button_economy.y and mousey < gui.button_economy.y + gui.button_economy.height then
        if love.mouse.isDown(1) then
            currenttab = "economic"
        end
    end

    if mousex > gui.button_research.x and mousex < gui.button_research.x + gui.button_research.width and mousey > gui.button_research.y and mousey < gui.button_research.y + gui.button_research.height then
        if love.mouse.isDown(1) then
            currenttab = "research"
        end
    end
end


function gui.draw()

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)

    love.graphics.setFont(mediumfont)
    drawCountryFlag()

    -- TODO: make these actually work [50%]

    newButton(gui.button_political.x, gui.button_political.y, gui.button_political.width, gui.button_political.height, gui.button_political.color, gui.button_political.isHovered, gui.button_political.text)
    newButton(gui.button_economy.x, gui.button_economy.y, gui.button_economy.width, gui.button_economy.height, gui.button_economy.color, gui.button_economy.isHovered, gui.button_economy.text)
    newButton(gui.button_research.x, gui.button_research.y, gui.button_research.width, gui.button_research.height, gui.button_research.color, gui.button_research.isHovered, gui.button_research.text)

    if currenttab == "political" then
        drawPoliticalTab()
    elseif currenttab == "economic" then
        drawEconomicTab()
    elseif currenttab == "research" then
        drawResearchTab()
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(bigfont)
    love.graphics.printf(date, 0, 0, topbar.width, "right")
end
