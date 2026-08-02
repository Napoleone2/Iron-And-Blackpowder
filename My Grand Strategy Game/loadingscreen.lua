-- this file manages the "loading"😏 of assets in the game

require("fonts")

function load()
    loadingbar = {}
    loadingbar.x = 0
    loadingbar.y = wh / 1.125
    loadingbar.width = 0
    loadingbar.height = wh

    lovelogo = love.graphics.newImage("Data/Images/Love2D.png")
    lovewidth = lovelogo:getWidth()
    loveheight = lovelogo:getHeight()
end

function loadupdate(speed)
    loadingbar.width = loadingbar.width + speed * 1
    if loadingbar.width > ww and gamestate == "initialloading" then
        print("loading complete!")
        gamestate = "menu"
        loadingbar.width = 0
    end

    if loadingbar.width > ww and gamestate == "maingameloading" then
        gamestate = "game"
        loadingbar.width = 0
        print("loading complete!")
        loadingbar.width = 0
    end
end

function drawload()

    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", 0, 0, ww, wh)

    love.graphics.setColor(205/255, 178/255, 131/255)
    love.graphics.rectangle("fill", loadingbar.x, loadingbar.y, ww, loadingbar.height)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(lovelogo, ww / 2, wh / 2, 0, 3, 3, lovewidth / 2, loveheight / 2)

    love.graphics.setColor(135/255, 108/255, 61/255) 
    love.graphics.rectangle("fill", loadingbar.x, loadingbar.y, loadingbar.width, loadingbar.height)

    love.graphics.setFont(hugefont)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Made With", 0, wh / 2 - loveheight * 2.5, ww, "center")
    love.graphics.printf("Love2D", 0, wh / 2 + loveheight * 2, ww, "center")
end
