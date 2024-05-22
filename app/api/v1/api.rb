module V1
  class Api < Grape::API
    format :json
    mount Users
    add_swagger_documentation base_path: '/api/v1',
                              hide_documentation_path: true,
                              doc_version: '0.0.1',
                              info: {
                                title: 'User API',
                                description: 'APIs using in Game Portal'
                              },
                              # endpoint_auth_wrapper: Middlewares::JwtAuthentication,
                              array_use_braces: true

  end
end
