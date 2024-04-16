# frozen_string_literal: true

module Artists
  class Api < Grape::API
    format :json

    mount Artists

    add_swagger_documentation base_path: '/artist_api',
                              hide_documentation_path: true,
                              doc_version: '0.0.1',
                              info: {
                                title: 'Artist API',
                                description: 'APIs using for artist'
                              },
                              endpoint_auth_wrapper: Middlewares::ArtistJwtAuthentication,
                              array_use_braces: true
  end
end
