-- ==========================================
-- 1. INITIALIZATION (Call this in love.load)
-- ==========================================
function loadtime()
    months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}

    time = 0
    time_speed = 1
    time_paused = true
    paused = "Paused"
    
    -- How many game "ticks" or days pass per 1 real-world second at Speed 1
    -- Adjust this to make the game calendar faster or slower!
    time_scale = 1
end

-- ==========================================
-- 2. TIME MANAGER (Call this in love.update(dt))
-- ==========================================
function timemgr()
    -- Handle the Pause text state
    if time_paused then
        paused = "Paused"
    else
        paused = "Speed: " .. time_speed
    end

    -- Process time progression
    if gamestate == "game" and not time_paused then
        time = time + (time_speed * time_scale )
    end

    -- Calendar Calculations
    -- (100 units of 'time' = 1 day)
    -- Using the lunar calendar so i don't have to calculate days for each month and leap years
    days = math.floor(time / 100)
    month = math.floor(days / 28)
    year = math.floor(month / 12) + 684          -- Start at Year 684
    month_of_year = math.floor(month % 12) + 1
    day_of_month = math.floor(days % 28) + 1    -- Day 1 to Day 28
end

-- ==========================================
-- 3. KEYBOARD CALLBACK (Define globally, on its own!)
-- ==========================================
function love.keypressed(key)
    -- Speed Controls
    if key == "1" then
        time_speed = 1
    elseif key == "2" then
        time_speed = 5
    elseif key == "3" then
        time_speed = 10
    end

    -- Spacebar pause Toggle
    if key == "space" then
        -- This elegant one-liner flips true to false, and false to true!
        time_paused = not time_paused 
    end
end