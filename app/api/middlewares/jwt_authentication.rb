# frozen_string_literal: true

module Middlewares
  class JwtAuthentication
    CLIENT_ID_KEYS = %w[CLIENT_ID HTTP_CLIENT_ID X-HTTP_CLIENT_ID X_HTTP_CLIENT_ID].freeze
    HOST_KEYS = %w[HOST HTTP_HOST X-HTTP_HOST X_HTTP_HOST].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      auth = JwtRequest.new(env)
      return unauthorized('Authentication required') unless auth.valid?
      return unauthorized('Authentication required') unless auth.bearer?
      return unauthorized('Invalid authentication') unless auth.user_data
      return forbidden('IP blocked') if auth.ip_blocked?

      env['REMOTE_USER'] = auth.user_data
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

    class JwtRequest < Rack::Auth::AbstractRequest
      def bearer?
        scheme == 'bearer' && credentials.length == 2
      end

      def public_key
        OpenSSL::PKey::RSA.new(platform.public_key)
      end

      def credentials
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

      def client_id_key
        CLIENT_ID_KEYS.detect { |key| @env.key?(key) }
      end

      def platform
        @platform ||= Platform.find_by!('client_id = ? OR ? = ANY(hosts)', client_id, host)
      end

      def client_id
        @env[client_id_key]
      end

      def host_key
        HOST_KEYS.detect { |key| @env.key?(key) }
      end

      def host
        @env[host_key]
      end
    end
  end
end
