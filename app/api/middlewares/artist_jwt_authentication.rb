# frozen_string_literal: true

module Middlewares
  class ArtistJwtAuthentication
    CLIENT_ID_KEYS = %w[CLIENT_ID HTTP_CLIENT_ID X-HTTP_CLIENT_ID X_HTTP_CLIENT_ID].freeze
    HOST_KEYS = %w[HOST HTTP_HOST X-HTTP_HOST X_HTTP_HOST].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      auth = JwtRequest.new(env)
      return unauthorized('Authentication required') unless auth.valid?
      return unauthorized('Authentication required') unless auth.bearer?
      return unauthorized('Invalid authentication') unless auth.artist_data
      if auth.artist_data.present? && !auth.artist_data.active 
        return unauthorized('Inactive user')
      end

      env['REMOTE_ARTIST'] = auth.artist_data
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
        OpenSSL::PKey::RSA.new(ENV['ARTIST_JWT_PUBLIC_KEY'].gsub('\\n', "\n"))
      end

      def credentials
        @credentials ||= JWT.decode(params, public_key, true, algorithm: 'RS256')
      end

      def artist_data
        credentials.first['artist']
      end
    end
  end
end
