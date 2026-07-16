
function loadtime()
    time = 0
    time_speed = 1
    time_paused = true
    paused = " "
end

function timemgr()

    function love.keypressed(key)
        if key == "1" then
            time_speed = 1
        end
        if key == "2" then
            time_speed = 5
        end
        if key == "3" then
            time_speed = 10
        end
        if key == "space" and time_paused == true then
            time_paused = false
        elseif key == "space" and time_paused == false then
            time_paused = true
        end

    end

    if time_paused == true then
        paused = "Paused"
    else
        paused = " "
    end

    days = math.floor(time / 100)
    year = days / 365

    if gamestate == "game" and time_paused == false then
        time = time + time_speed
    end
end
