# frozen_string_literal: true

module Middlewares
  class PublicAuthentication
    def initialize(app)
      @app = app
    end

    def call(env)
      auth = Request.new(env)
      return forbidden('IP blocked') if auth.ip_blocked?

      @app.call(env)
    end

    private

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

    class Request < Rack::Auth::AbstractRequest
      def ip_blocked?
        # BlockedIpAddress.exists?(ip_address: client_ip)
        false
      end

      def client_ip
        @env['action_dispatch.remote_ip'].to_s
      end
    end
  end
end
