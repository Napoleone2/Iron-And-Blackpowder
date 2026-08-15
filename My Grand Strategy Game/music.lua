music = {}

function music.load()
    startup_music = love.audio.newSource("Data/Sound/Music/hoi2-kriegsgewitter.mp3", "stream")
    countryside = love.audio.newSource("Data/Sound/Music/countryside.mp3", "stream")
end

function music.play()
    love.audio.play(countryside)
end