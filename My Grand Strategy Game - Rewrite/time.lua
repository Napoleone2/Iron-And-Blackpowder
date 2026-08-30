local time = {
	paused = true,
    tick = 0,
    day = 1,
    month = 1,
    year = 1,
    day_of_month = 1,
    month_of_year = 1,
    months = {
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    }
}

function time.update(dt)
    time.tick = time.tick + 1
end

function time.keypressed(key)

end

return time
