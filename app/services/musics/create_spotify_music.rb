module Musics
  class CreateSpotifyMusic < ServiceBase
    attr_reader :track_id, :access_token

    def initialize(track_id:, access_token:)
      @track_id = track_id
      @access_token = access_token
    end

    def call
      headers = {
        'Authorization' => "Bearer #{access_token}"
      }
      track = HTTParty.get("https://api.spotify.com/v1/tracks/#{track_id}", headers:)

      music = Music.find_by(music_external_id: track['id'])
      artists_clone = 0
      new_music = false
      if music.present?
        music.update!(
          name: track['name'],
          music_external_id: track['id'],
          source_url: track['preview_url'],
          description: '',
          images: track['images'],
          release_date: track['release_date'],
          release_date_precision: track['release_date_precision']
        )
      else
        new_music = true
        music = Music.create!(
          name: track['name'],
          music_external_id: track['id'],
          source_url: track['preview_url'],
          description: '',
          images: track['images'],
          release_date: track['release_date'],
          release_date_precision: track['release_date_precision']
        )
      end
      track['artists'].each do |artist|
        artist = if Artist.find_by(artist_external_id: artist['id']).nil?
                   artist_detail = HTTParty.get("https://api.spotify.com/v1/artists/#{artist['id']}", headers:)
                   artists_clone += 1
                   Artist.create!(
                     email: "#{artist_detail['name'].split(' ')[0] + SecureRandom.hex[1..5]}@gmail.com",
                     name: artist_detail['name'],
                     artist_external_id: artist_detail['id'],
                     images: artist_detail['images'],
                     genres: artist_detail['genres'],
                     followers_count: artist_detail['followers']['total'],
                     password: 'Artist@123'
                   )
                 else
                   Artist.find_by(artist_external_id: artist['id'])
                 end
        next if MusicArtist.find_by(music_id: music.id, artist_id: artist.id).present?

        MusicArtist.create!(
          music_id: music.id,
          artist_id: artist.id
        )
      end
      { artists_clone:, new_music:, music: }
    end
  end
end
