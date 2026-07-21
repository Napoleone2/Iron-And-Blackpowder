require("time")
require("country_select")
require("country_buttons")
local countries = require("Countries")
require("button")
require("political_tab")
require("hovered")


ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

mousex, mousey = love.mouse.getPosition()

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

    gui.smallFont = love.graphics.newFont("Data/Reblade-Regular.otf", 35)

    gui.flag_button = {}
    gui.flag_button.x = gui.flag.x
    gui.flag_button.y = gui.flag.y
    gui.flag_button.color = {0.22, 0.22, 0.22, 0}
    gui.flag_button.isHovered = false
    gui.flag_button.text = "blank"
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
        -- Draw the selected country's flag in the top-left corner.
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
            newButton(gui.flag_button.x, gui.flag_button.y, drawWidth, drawHeight, gui.flag_button.color, gui.flag_button.isHovered, gui.flag_button.text)
        end

    end
    drawCountryFlag()

    gui.flag_button.isHovered = ishovered(gui.flag_button.x, gui.flag_button.y, drawWidth, drawHeight, mousex, mousey)

    if isHovered then
        gui.flag_buttton.text = "hovered!"
    end

    if gui.flag_button.isHovered and love.mouse.isDown then
        currenttab = "political"
        gui.flag_button.text = "political"
    end
end


function gui.draw()

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)

    if currenttab == "political" then
        drawPoliticalTab()
    end

    drawCountryFlag()

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(gui.smallFont)
    love.graphics.printf(date, 0, 0, topbar.width, "right")
end
