--this file manages the "loading" of assets in the game

function load()
    loadingbar = {}
    loadingbar.x = 0
    loadingbar.y = wh / 1.125
    loadingbar.width = 0
    loadingbar.height = wh

    bigfont = love.graphics.newFont("Data/Reblade-Regular.otf", 40)
end

function loadupdate(speed)
    print("loading:" .. loadingbar.width / ww * 100 .. "%")
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
    end
end

function drawload()


    love.graphics.setColor(255/255, 228/255, 181/255)
    love.graphics.rectangle("fill", 0, 0, ww, wh)

    love.graphics.setColor(205/255, 178/255, 131/255)
    love.graphics.rectangle("fill", loadingbar.x, loadingbar.y, ww, loadingbar.height)

    love.graphics.setColor(135/255, 108/255, 61/255) 
    love.graphics.rectangle("fill", loadingbar.x, loadingbar.y, loadingbar.width, loadingbar.height)

    love.graphics.setFont(bigfont)
    love.graphics.printf("Loading Game. Please Wait", 0,  wh /2, ww, "center")
    love.graphics.printf("loading:" .. loadingbar.width / ww * 100 .. "%", ww / 2, 0, ww, "center")
end
