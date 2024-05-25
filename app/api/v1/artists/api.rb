module V1
  module Artists
    class Api < Grape::API
      format :json
      mount PublicArtist
      mount Artists
      mount Profile
      mount Musics
      mount ::V1::Users::PublicMusics
      mount ::V1::Users::PublicPlaylists
      add_swagger_documentation hide_documentation_path: true,
                                mount_path: "/artist_swagger_doc_v1",
                                doc_version: '0.0.1',
                                api_version: "v1",
                                info: {
                                  title: 'Artist API v1',
                                },
                                # endpoint_auth_wrapper: Middlewares::JwtAuthentication,
                                array_use_braces: true

    end
  end
end