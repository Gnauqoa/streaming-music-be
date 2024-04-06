# frozen_string_literal: true

module ApiHelper
  def jwt_headers
    return {} unless respond_to?(:user)

    token = JWT.encode(
      user.decorate&.jwt_payload.to_h,
      OpenSSL::PKey::RSA.new(user.platform.private_key),
      'RS256'
    )
    {
      'Authorization': "Bearer #{token}",
      'Client-ID': user.platform.client_id
    }
  end

  def jwt_headers_with_host
    return {} unless respond_to?(:user)
    return {} unless respond_to?(:host)

    @request.host = host

    token = JWT.encode(
      user.decorate&.jwt_payload.to_h,
      OpenSSL::PKey::RSA.new(user.platform.private_key),
      'RS256'
    )
    {
      'Authorization': "Bearer #{token}"
    }
  end

  def client_id_headers
    return {} unless respond_to?(:platform)

    {
      'Client-ID': platform.client_id
    }
  end

  def response_body
    JSON.parse(response.body)
  end

  def response_data
    response_body['data'].with_indifferent_access
  end

  def response_error
    response_body['error'].with_indifferent_access
  end
end
