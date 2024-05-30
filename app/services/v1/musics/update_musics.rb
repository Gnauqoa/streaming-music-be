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

          if music.source_url.nil?
            music.update!(
              source_url: "https://p.scdn.co/mp3-preview/fa63d14fba831e3cea281c733196475f1e7c1275?cid=d8a5ed958d274c2e8ee717e6a4b0971d",
              images: new_muisc['album']['images'],
              duration_ms: new_muisc['duration_ms']
            )
          else 
            music.update!(
              images: new_muisc['album']['images'],
              duration_ms: new_muisc['duration_ms']
            )
          end

         
        end
      end
    end
  end
end