-- TODO: uhhh

function ishovered(x, y, width, height, mousex, mousey)
    isHovered = 0

    if mousex > x and mousey > y and mousex < x + width and mousey < y + height then
        isHovered = true
    else
        isHovered = false
    end

    return isHovered
end