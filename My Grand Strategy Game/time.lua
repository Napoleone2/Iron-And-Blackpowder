function loadtime()
    months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
    special_day_suffix = { "st", "nd", "rd" }
    time = 0
    time_speed = 1
    time_paused = true
    paused = "Paused"
    
    time_scale = 1

end

function timemgr()
    if time_paused then
        paused = "Paused"
    else
        paused = "Speed: " .. time_speed
    end

    if gamestate == "game" and not time_paused then
        time = time + (time_speed * time_scale )
    end

    days = math.floor(time / 100)
    month = math.floor(days / 30)
    year = math.floor(month / 12) + 684          -- Start at Year 684
    month_of_year = math.floor(month % 12) + 1
    day_of_month = math.floor(days % 30) + 1    -- Day 1 to Day 28
    
    function add_suffix()
        suffix = "th"
        if day_of_month ~= 11 and day_of_month ~= 12 and day_of_month ~= 13 and day_of_month % 10 >= 1 and day_of_month % 10 <= 3 then
            suffix = special_day_suffix[day_of_month % 10]
        end
    end
    add_suffix()

    date = day_of_month .. suffix .. " of " .. months[month_of_year] .. " " .. year .. " | " .. paused

end

function love.keypressed(key)
    if key == "1" then
        time_speed = 1
    elseif key == "2" then
        time_speed = 5
    elseif key == "3" then
        time_speed = 10
    end

    if key == "space" then
        time_paused = not time_paused 
    end
end