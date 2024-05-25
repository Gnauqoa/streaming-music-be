module V1
  module Artists
    class GetArtists < ServiceBase
      def initialize; end

      def call
        token = 'BQAtmgrG3Q_xtpSQrnsYZ5wPLSvveZH3aee2eNNoI9jltU2insq4lk_R7Wa71bFe8Dw8Vlb68EndEK3HjG8ZZsNIpjIWu0OsXTWB49-NdldwOTO1QcP39VPq2ILLwOfxJ7N5enYS_pDN6YUknLU3nsVo3uJqHUqG7RHe9Um5hft-loUZEgtzlWnRZ6y6m9-_lHuV0WhYGcbw1Uc12bhc_3SD6k4AQGppQf9RpMrmk-bDRqNJ_7H54TeI-HVE1lJ9qwUbukkuB7Z8ADj50c_Cl8YdJSuDT5qIcFCu6mjNmGDsku1CwcG7eKf2L0qajBq7YhbVC1zjWBGJHbn5DRdaDngANhbX'
        res = HTTParty.get(
          'https://api.spotify.com/v1/search?query=bob&type=artist&market=us&limit=1&offset=0',
          headers: {
            'Authorization' => "Bearer #{token}"
          }
        )
        items = res['artists']['items']

        items.each do |artist|
          {
            name: artist['name'],
            avatar: artist['images'][0]['url'],
            spotify_id: artist['id']
          }
        end
      end
    end
  end
end
