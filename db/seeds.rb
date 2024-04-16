# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

platform = Platform.create!(
  name: 'Streaming',
  client_id: "326ff5654b87fa2a31289ad03d7cb8e3"
)

user_0 = User.create!(first_name: 'Ika', last_name: 'of Company Agent', password: '123123123@q', email: 'user@streaming.com')
user_1 = User.create!(first_name: 'Mary', last_name: 'of Agent 1', password: '123123123@q', email: 'user1@streaming.com')
user_2 = User.create!(first_name: 'John', last_name: 'of Agent 2', password: '123123123@q', email: 'user2@streaming.com')
user_3 = User.create!(first_name: 'Jory', last_name: 'of Agent 3', password: '123123123@q', email: 'user3@streaming.com')
user_4 = User.create!(first_name: 'Mahn', last_name: 'of Agent 4', password: '123123123@q', email: 'user4@streaming.com')

playlist_0 = Playlist.create!(name: 'Playlist 0', user: user_0)
playlist_1 = Playlist.create!(name: 'Playlist 1', user: user_1)
playlist_2 = Playlist.create!(name: 'Playlist 2', user: user_2)
playlist_3 = Playlist.create!(name: 'Playlist 3', user: user_3)
playlist_4 = Playlist.create!(name: 'Playlist 4', user: user_4)

artist_0 = Artist.create!(name: 'Taylor Swift', description: "Taylor 
Alison Swift is an American singer-songwriter. A subject of widespread public interest, she has influenced the music 
industry and popular culture through her artistry, especially in songwriting, and entrepreneurship. She is an advocate 
of artists' rights and women's empowerment.", avatar_url: "https://www.usmagazine.com/wp-content/uploads/2023/10/Taylor-Swifts-Family-Guide-Meet-the-Singers-Supportive-Parents-and-Younger-Brother1.jpg?w=800&h=1421&crop=1&quality=86&strip=all")

music_0 = Music.create!(name: 'Lover', description: "Lover is the seventh studio album by the American 
singer-songwriter Taylor Swift, released on August 23, 2019, by Republic Records. It is her first album 
after her departure from Big Machine Records, which caused a public dispute over the ownership of 
Swift's past albums.",
artist_id: artist_0.id, 
source_url: 'https://res.cloudinary.com/dqx3ctfxx/video/upload/v1713261748/streaming/sources/bjdzax00opeiwgzgj0sx.mp3',
thumbnail_url: '')

playlist_music_0 = PlaylistMusic.create!(playlist: playlist_0, music: music_0)