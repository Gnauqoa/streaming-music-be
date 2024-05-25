module V1
  module Musics
    class GetSpotifyMusics < ServiceBase
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
          result = CreateSpotifyMusic.new(track_id: track["id"], access_token:).call
          artists_clone += result[:artists_clone]
          musics_clone += 1 if result[:new_music]
        end
        "Import #{musics_clone} musics and #{artists_clone} artists successfully!"
      end
    end
  end
end