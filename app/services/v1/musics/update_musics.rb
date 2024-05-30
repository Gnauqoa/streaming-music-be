module V1
  module Musics
    class UpdateMusics 
      attr_reader :access_token
      def initialize(access_token:)
        @access_token = access_token
      end
      def call
        headers = {
          'Authorization' => "Bearer #{access_token}"
        }
        Music.all.each do |music|
          new_muisc = HTTParty.get("https://api.spotify.com/v1/tracks/#{music.music_external_id}", headers:)
          music.update!(
            images: new_muisc['album']['images'],
            duration_ms: new_muisc['duration_ms']
          )
        end
      end
    end
  end
end