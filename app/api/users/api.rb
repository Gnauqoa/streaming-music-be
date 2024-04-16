# frozen_string_literal: true

module Users
  class Api < Grape::API
    format :json

    mount Profile
    mount Users
    mount Playlists
    mount Artists
    add_swagger_documentation base_path: '/user_api',
                              hide_documentation_path: true,
                              doc_version: '0.0.1',
                              info: {
                                title: 'User API',
                                description: 'APIs using in Game Portal'
                              },
                              endpoint_auth_wrapper: Middlewares::UserJwtAuthentication,
                              array_use_braces: true
  end
end
