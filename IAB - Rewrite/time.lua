local city_data = require("city_data")
local countries = require("countries")
local time = {}

function time.load()
    time.paused = true
    time.timer = 0
    time.speed = 1
    time.day_duration = 0.75

    time.day = 1
    time.day_of_month = 1
    time.month_of_year = 1
    time.year = 684

    time.months = {
        "January", "February", "March", "April", "May", "June", 
        "July", "August", "September", "October", "November", "December"
    }

    time.updateDateString()
end

function time.updateDateString()
    time.date = time.day_of_month .. " / " .. time.months[time.month_of_year] .. " / " .. time.year
end

function time.advanceDay()
    time.day = time.day + 1
    time.day_of_month = time.day_of_month + 1

    if time.day_of_month > 30 then
        time.day_of_month = 1
        time.month_of_year = time.month_of_year + 1

        if time.month_of_year > 12 then
            time.month_of_year = 1
            time.year = time.year + 1
        end

        time.onMonthTick()
    end

    time.updateDateString()
    time.onDayTick()
end

function time.update(dt)
    if time.paused then return end

    time.timer = time.timer + dt * time.speed

    while time.timer >= time.day_duration do
        time.timer = time.timer - time.day_duration
        time.advanceDay()
    end
end

function time.onDayTick()
    for i, country in ipairs(countries) do
        country.treasury = country.treasury + 100
    end
    for i, country in ipairs(countries) do
        country.population = 0
        for i, city in ipairs(city_data) do
            if country.id == city.controller and city.controller ~= "none" then
                country.population = country.population + city.population
            end
        end
    end
end

function time.onMonthTick()
    
end

function time.keypressed(key)
    if key == "space" then
        time.paused = not time.paused
    elseif key == "1" then
        time.speed = 1
        time.paused = false
    elseif key == "2" then
        time.speed = 2
        time.paused = false
    elseif key == "3" then
        time.speed = 5
        time.paused = false
    end
end

return time