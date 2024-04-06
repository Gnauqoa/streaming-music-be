# frozen_string_literal: true

module Middlewares
  class AgentJwtAuthentication
    def initialize(app)
      @app = app
    end

    def call(env)
      auth = JwtRequest.new(env)
      return unauthorized('Authentication required') unless auth.valid?
      return unauthorized('Authentication required') unless auth.bearer?
      return unauthorized('Invalid authentication') unless auth.user_data

      env['REMOTE_AGENT'] = auth.user_data
      @app.call(env)
    rescue JWT::DecodeError => e
      unauthorized(e.message)
    end

    private

    def unauthorized(errors = [])
      [401,
       {
         Rack::CONTENT_TYPE => 'application/json'
       },
       [
         {
           error: {
             message: :unauthorized,
             errors: errors.is_a?(Array) ? errors : [errors]
           }
         }.to_json
       ]]
    end

    class JwtRequest < Rack::Auth::AbstractRequest
      def bearer?
        scheme == 'bearer' && credentials.length == 2
      end

      def public_key
        OpenSSL::PKey::RSA.new(ENV['ADMIN_JWT_PUBLIC_KEY'].gsub("\\n", "\n"))
      end

      def credentials
        @credentials ||= JWT.decode(params, public_key, true, algorithm: 'RS256')
      end

      def user_data
        credentials.first['agent']
      end
    end
  end
end
