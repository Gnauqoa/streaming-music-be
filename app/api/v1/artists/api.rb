module V1
  module Artists
    class Api < Grape::API
      format :json

      add_swagger_documentation base_path: '/api/v1',
                                hide_documentation_path: true,
                                mount_path: "artist_swagger_doc",
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