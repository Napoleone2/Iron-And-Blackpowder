local music = {}

function music.load()
    music.playlist = {
        love.audio.newSource("Data/Sound/Music/hoi2-kriegsgewitter.mp3", "stream"),
        love.audio.newSource("Data/Sound/Music/countryside.mp3", "stream"),
        love.audio.newSource("Data/Sound/Music/From_Russia_with_Love.mp3", "stream")
    }
    
    music.current_index = 1
    music.is_playing = false
end

function music.play()
    love.audio.play(music.playlist[3])
end

return music