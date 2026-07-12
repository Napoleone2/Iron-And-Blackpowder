require("button")
local country_buttons = require("the_generator_script_for_the_buttons_you_click_to_select_which_country_you_want_to_play_as")

local country_select = {}

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local bigfont = love.graphics.newFont("Data/Reblade-Regular.otf", 40)
local medfont = love.graphics.newFont("Data/Reblade-Regular.otf", 24)

local topbar
local cs_body
local lorebox
local buttonbox
local startbutton
local backbutton
local mousex, mousey = 0, 0
local starthovered = false
local backhovered = false
local playerCountry = nil

function country_select.load()
    topbar = {}
    topbar.x = 0
    topbar.y = 0
    topbar.width = ww
    topbar.height = wh / 19
    topbar.color = {255/255, 228/255, 181/255}

    cs_body = {}
    cs_body.x = 0
    cs_body.y = topbar.height
    cs_body.width = ww
    cs_body.height = 0.75 * wh
    cs_body.color = {235/255, 208/255, 161/255}

    lorebox = {}
    lorebox.x = 0
    lorebox.y = cs_body.y + cs_body.height
    lorebox.width = ww - ww / 6
    lorebox.height = wh - cs_body.y - cs_body.height
    lorebox.color = {205/255, 178/255, 131/255}

    buttonbox = {}
    buttonbox.x = ww / 1.2
    buttonbox.y = lorebox.y
    buttonbox.width = ww / 6
    buttonbox.height = 0.2 * wh
    buttonbox.color = {235/255, 208/255, 161/255}

    startbutton = {}
    startbutton.x = buttonbox.x
    startbutton.y = buttonbox.y
    startbutton.width = buttonbox.width
    startbutton.height = buttonbox.height / 3
    startbutton.color = {135/255, 108/255, 61/255}
    startbutton.text = "Start"

    backbutton = {}
    backbutton.x = buttonbox.x
    backbutton.y = buttonbox.y + buttonbox.height / 2
    backbutton.width = buttonbox.width
    backbutton.height = buttonbox.height / 3
    backbutton.color = {135/255, 108/255, 61/255}
    backbutton.text = "Back"

    country_buttons.load()
    playerCountry = country_buttons.getSelectedCountry()
end

function country_select.update(dt)
    mousex, mousey = love.mouse.getPosition()

    country_buttons.update(mousex, mousey, love.mouse.isDown(1))
    playerCountry = country_buttons.getSelectedCountry()

    starthovered = mousex > startbutton.x and mousex < startbutton.x + startbutton.width and mousey > startbutton.y and mousey < startbutton.y + startbutton.height
    backhovered = mousex > backbutton.x and mousex < backbutton.x + backbutton.width and mousey > backbutton.y and mousey < backbutton.y + backbutton.height

    if backhovered and love.mouse.isDown(1) then
        gamestate = "menu"
    end

    if starthovered and love.mouse.isDown(1) then
        if playerCountry then
            selectedCountry = playerCountry
            gamestate = "game"
        end
    end
end

function country_select.draw()
    love.graphics.setColor(topbar.color[1], topbar.color[2], topbar.color[3])
    love.graphics.rectangle("fill", topbar.x, topbar.y, topbar.width, topbar.height)

    love.graphics.setColor(cs_body.color[1], cs_body.color[2], cs_body.color[3])
    love.graphics.rectangle("fill", cs_body.x, cs_body.y, cs_body.width, cs_body.height)

    love.graphics.setColor(lorebox.color[1], lorebox.color[2], lorebox.color[3])
    love.graphics.rectangle("fill", lorebox.x, lorebox.y, lorebox.width, lorebox.height)

    love.graphics.setColor(buttonbox.color[1], buttonbox.color[2], buttonbox.color[3])
    love.graphics.rectangle("fill", buttonbox.x, buttonbox.y, buttonbox.width, buttonbox.height)

    love.graphics.setColor(topbar.color[1], topbar.color[2], topbar.color[3])
    love.graphics.rectangle("fill", buttonbox.x, topbar.y + topbar.height, ww / 6, wh - buttonbox.height - topbar.height)

    love.graphics.setFont(bigfont)

    country_buttons.draw()

    love.graphics.setFont(bigfont)
    newButton(startbutton.x, startbutton.y, startbutton.width, startbutton.height, startbutton.color, starthovered, startbutton.text)
    newButton(backbutton.x, backbutton.y, backbutton.width, backbutton.height, backbutton.color, backhovered, backbutton.text)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(bigfont)
    love.graphics.printf("Select a Country", topbar.x, topbar.y + topbar.height / 20, topbar.width, "center")

    local selected = country_buttons.getSelectedCountry()
    local details = ""
    if selected then
        details = string.format("%s\n\n%s", selected.name, selected.lore)
    end

    love.graphics.setFont(medfont)
    love.graphics.printf(details, lorebox.x + 20, lorebox.y + lorebox.height / 20, lorebox.width - 40, "left")
end

return country_select


