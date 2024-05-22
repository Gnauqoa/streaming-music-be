GrapeSwaggerRails.options.url                   = '/swagger_doc.json'
GrapeSwaggerRails.options.doc_expansion         = 'list'
GrapeSwaggerRails.options.api_auth              = 'bearer'
GrapeSwaggerRails.options.api_key_name          = 'Authorization'
GrapeSwaggerRails.options.api_key_type          = 'header'
GrapeSwaggerRails.options.hide_url_input        = true

GrapeSwaggerRails.options.before_action do
  authenticate_or_request_with_http_basic do |username, password|
    username == 'streaming' && password == '123456'
  end
  # GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  # case request.path
  # when '/user-api-docs/'
  #   GrapeSwaggerRails.options.url = '/user_api/swagger_doc.json'
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == 'streaming' && password == '123456'
  #   end
  # when '/artist-api-docs/'
  #   GrapeSwaggerRails.options.url = '/artist_api/swagger_doc.json'
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == 'streaming' && password == '123456'
  #   end
  # end
end