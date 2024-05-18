module Musics
  class GetSpotifyMusics
    attr_reader :access_token, :limit

    def initialize(access_token:, limit: 10)
      @access_token = access_token
      @limit = limit
    end

    def call
      headers = {
        'Authorization' => "Bearer #{access_token}"
      }
      artists_clone = 0
      musics_clone = 0
      res = HTTParty.get("https://api.spotify.com/v1/search?q=a&type=track&limit=#{limit}&offset=1", headers:)
      res['tracks']['items'].map do |track|
        next if Music.find_by(music_external_id: track['id']).present?

        musics_clone += 1
        music = Music.create!(
          name: track['name'],
          music_external_id: track['id'],
          source_url: track['preview_url'],
          description: '',
          images: track['images'],
          release_date: track['release_date'],
          release_date_precision: track['release_date_precision']
        )
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
      end
      "Import #{res['tracks']['items'].length} musics and #{artists_clone} artists successfully!"
    end
  end
end
