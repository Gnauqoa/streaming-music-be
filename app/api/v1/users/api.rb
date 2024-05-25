module V1
  module Users
      class Api < Grape::API
      format :json

      mount Profile
      mount Users
      mount Playlists
      mount Search
      mount Musics
      mount PublicMusics
      mount PublicPlaylists
      mount ::V1::Artists::PublicArtist
      add_swagger_documentation base_path: '/api/v1',
                                hide_documentation_path: true,
                                mount_path: "user_swagger_doc",
                                doc_version: '0.0.1',
                                api_version: "v1",
                                info: {
                                  title: 'User API v1',
                                },
                                array_use_braces: true

    end
  end
end
