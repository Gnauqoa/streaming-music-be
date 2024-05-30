module V1
  module Musics
    class GetSpotifyMusics < ServiceBase
      attr_reader :access_token, :limit, :query

      def initialize(access_token:, limit: 10, query: nil)
        @access_token = access_token
        @limit = limit
        @query = query
      end

      def call
        headers = {
          'Authorization' => "Bearer #{access_token}"
        }
        artists_clone = 0
        musics_clone = 0
        res = HTTParty.get("https://api.spotify.com/v1/search?q=a&type=track&limit=#{limit}&offset=1&q=#{query}", headers:)
        puts "images: #{res["tracks"]["items"][0]['album']['images']}"
        res['tracks']['items'].map do |track|
          result = CreateSpotifyMusic.new(track:, access_token:).call
          artists_clone += result[:artists_clone]
          musics_clone += 1 if result[:new_music]
        end
        "Import #{musics_clone} musics and #{artists_clone} artists successfully!"

      end
    end
  end
end