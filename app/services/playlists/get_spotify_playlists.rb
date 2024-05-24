module Playlists
  class GetSpotifyPlaylists < ServiceBase
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
      playlist_clone = 0
      res = HTTParty.get("https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=playlist&limit=#{limit}&offset=1", headers:)
      res['playlists']['items'].map do |playlist|
        result = CreateSpotifyPlaylist.new(playlist:, access_token:).call
        artists_clone += result[:artists_clone]
        musics_clone += result[:musics_clone]
        playlist_clone += 1 if result[:new_playlist]
      end
      puts "Import #{musics_clone} musics, #{artists_clone} artists and #{playlist_clone} playlists successfully!"
    end
  end
end
