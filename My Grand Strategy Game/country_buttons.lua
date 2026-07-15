require("button")
local countries = require("Countries")

local country_buttons = {}

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local panel = {
    x = 0,
    y = wh / 19,
    width = ww - ww / 6,
    height = wh - wh / 19
}

local itemFont = love.graphics.newFont("Data/Reblade-Regular.otf", 18)
local itemHeight = 90
local itemSpacing = 12
local itemMargin = 20
local columns = 3

local items = {}
local selectedIndex = 1
local hoverIndex = nil
local mouseDownLast = false

local function createItems()
    items = {}
    local columnWidth = (panel.width - itemMargin * 2 - itemSpacing) / columns

    for i, country in ipairs(countries) do
        local col = (i - 1) % columns
        local row = math.floor((i - 1) / columns)

        local item = {
            country = country,
            flag = love.graphics.newImage(country.flag),
            x = panel.x + itemMargin + col * (columnWidth + itemSpacing),
            y = panel.y + itemMargin + row * (itemHeight + itemSpacing),
            width = columnWidth,
            height = itemHeight,
            color = country.color
        }

        table.insert(items, item)
    end
end

function country_buttons.load()
    createItems()
end

function country_buttons.update(mousex, mousey, mouseDown)
    hoverIndex = nil

    for i, item in ipairs(items) do
        if mousex >= item.x and mousex <= item.x + item.width and mousey >= item.y and mousey <= item.y + item.height then
            hoverIndex = i
            break
        end
    end

    if mouseDown and not mouseDownLast and hoverIndex then
        selectedIndex = hoverIndex
    end

    mouseDownLast = mouseDown
end

function country_buttons.draw()
    for i, item in ipairs(items) do
        local isHovered = hoverIndex == i
        local isSelected = selectedIndex == i

        newButton(item.x, item.y, item.width, item.height, item.color, isHovered, "")

        if isSelected then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineWidth(4)
            love.graphics.rectangle("line", item.x, item.y, item.width, item.height)
        end


        local flagScale = math.min(64 / item.flag:getWidth(), 64 / item.flag:getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(item.flag, item.x + 36, item.y + (item.height - item.flag:getHeight() * flagScale) / 2, 0, flagScale, flagScale)

        love.graphics.setFont(itemFont)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(item.country.name, item.x + 120, item.y + 18, item.width - 130, "left")
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(item.country.leader, item.x + 120, item.y + 48, item.width - 130, "left")
    end
end

function country_buttons.getSelectedCountry()
    return items[selectedIndex] and items[selectedIndex].country
end

return country_buttons
