-- Save this script as main.lua (or integrate it into yours)

function love.load()
    -- Initialize your time variables
    time = 0
    time_speed = 1        -- 1 means 1 day per real-world second
    time_paused = true
    paused = "Paused"
    gamestate = "game"
    
    -- Speed multipliers (how many game-days pass per real-world second)
    speeds = {
        [1] = 1,   -- Speed 1: 1 day/sec
        [2] = 5,   -- Speed 2: 5 days/sec
        [3] = 15   -- Speed 3: 15 days/sec
    }
    current_speed_index = 1
end

function love.update(dt)
    -- Only advance time if we are actively playing and not paused
    if gamestate == "game" and not time_paused then
        -- dt is the time passed in seconds since the last frame (~0.016 at 60fps)
        -- This ensures time moves at the exact same speed on all computers!
        time = time + (dt * speeds[current_speed_index])
    end
    
    -- Calculate calendar date from our flat 'time' counter
    calculate_calendar()
end

-- Define this OUTSIDE of any other function so Lua only loads it once
function love.keypressed(key)
    if gamestate == "game" then
        -- Handle speed changes
        if key == "1" then current_speed_index = 1 end
        if key == "2" then current_speed_index = 2 end
        if key == "3" then current_speed_index = 3 end
        
        -- Handle pause toggle
        if key == "space" then
            time_paused = not time_paused -- Clean way to toggle true/false
            if time_paused then
                paused = "Paused"
            else
                paused = " "
            end
        end
    end
end

-- Simple calendar helper math
local MONTHS = {
    { name = "January", days = 31 },
    { name = "February", days = 28 },
    { name = "March", days = 31 },
    { name = "April", days = 30 },
    { name = "May", days = 31 },
    { name = "June", days = 30 },
    { name = "July", days = 31 },
    { name = "August", days = 31 },
    { name = "September", days = 30 },
    { name = "October", days = 31 },
    { name = "November", days = 30 },
    { name = "December", days = 31 }
}

function calculate_calendar()
    -- Start Date: November 11, 1444 (EU4 style!)
    local start_day = 11
    local start_month = 11
    local start_year = 1444

    -- Total days passed since game start
    local total_days_passed = math.floor(time)
    
    -- Current date variables to calculate
    local d = start_day + total_days_passed
    local m = start_month
    local y = start_year

    -- Loop to carry over days into months, and months into years
    while true do
        -- Calculate if this year is a leap year
        local is_leap = (y % 4 == 0 and y % 100 ~= 0) or (y % 400 == 0)
        local days_in_month = MONTHS[m].days
        if m == 2 and is_leap then
            days_in_month = 29
        end

        if d <= days_in_month then
            break -- Day fits perfectly in this month
        end

        -- Day overflows; move to next month
        d = d - days_in_month
        m = m + 1
        if m > 12 then
            m = 1
            y = y + 1
        end
    end

    -- Save these to global variables so your UI drawing function can read them
    display_day = d
    display_month = MONTHS[m].name
    display_year = y
end

-- A quick mockup of how you would draw this to the screen in LÖVE
function love.draw()
    love.graphics.print(paused, 20, 20)
    love.graphics.print("Speed: " .. speeds[current_speed_index] .. "x", 20, 40)
    
    -- Show your beautiful, working grand strategy date!
    if display_day then
        local date_string = string.format("%d %s %d", display_day, display_month, display_year)
        love.graphics.print("Date: " .. date_string, 20, 60)
    end
end