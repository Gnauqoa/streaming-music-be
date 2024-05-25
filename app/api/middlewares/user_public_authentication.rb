# frozen_string_literal: true

module Middlewares
  class UserPublicAuthentication
    CLIENT_ID_KEYS = %w[CLIENT_ID HTTP_CLIENT_ID X-HTTP_CLIENT_ID X_HTTP_CLIENT_ID].freeze
    HOST_KEYS = %w[HOST HTTP_HOST X-HTTP_HOST X_HTTP_HOST].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      auth = JwtRequest.new(env)
      return forbidden('IP blocked') if auth.ip_blocked?

      env['REMOTE_USER'] = auth.user_data if auth.valid? && auth.bearer? && auth.user_data
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
        puts "bearer #{scheme} #{credentials}"
        scheme == 'bearer' && credentials.present? && credentials.length == 2
      end

      def public_key
        puts "public_key123"
        OpenSSL::PKey::RSA.new(ENV['USER_JWT_PUBLIC_KEY'].gsub('\\n', "\n"))
      end

      def credentials
        puts "credentials123"
        @credentials ||= JWT.decode(params, public_key, true, algorithm: 'RS256')
      end

      def user_data
        credentials.first['user']
      end

      def ip_blocked?
        BlockedIpAddress.exists?(ip_address: client_ip)
      end

      def client_ip
        @env['action_dispatch.remote_ip'].to_s
      end
    end

    def forbidden(errors = [])
      [403,
       {
         Rack::CONTENT_TYPE => 'application/json'
       },
       [
         {
           error: {
             message: :forbidden,
             errors: errors.is_a?(Array) ? errors : [errors]
           }
         }.to_json
       ]]
    end
  end
end
