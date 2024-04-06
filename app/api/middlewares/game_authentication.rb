# frozen_string_literal: true

module Middlewares
  class GameAuthentication
    SECRET_KEY_KEYS = %w[SECRET_KEYS HTTP_SECRET_KEY X-HTTP_SECRET_KEY X_HTTP_SECRET_KEY].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      auth = Request.new(env)

      return unauthorized if !auth.whitelisted_path? && !auth.game_provider

      env['secret_key'] = auth.secret_key
      @app.call(env)
    end

    private

    def unauthorized
      [401,
       {
         Rack::CONTENT_TYPE => 'application/json'
       },
       [
         {
           status: 0,
           error: 'ACCESS_DENIED'
         }.to_json
       ]]
    end

    class Request < Rack::Auth::AbstractRequest
      def secret_key_key
        SECRET_KEY_KEYS.detect { |key| @env.key?(key) }
      end

      def secret_key
        @env[secret_key_key]
      end

      def game_provider
        @game_provider ||= GameProvider.find_by(secret_key:)
      end

      def we_game_provider
        @we_game_provider ||= GameProvider.we.first
      end

      def whitelisted_paths
        %w[
          /game_api/games/we/validate
          /game_api/games/we/balance
          /game_api/games/we/debit
          /game_api/games/we/credit
          /game_api/games/we/rollback
          /game_api/games/pragmatic/authenticate
          /game_api/games/pragmatic/balance
          /game_api/games/pragmatic/bet
          /game_api/games/pragmatic/result
          /game_api/games/pragmatic/refund
          /game_api/games/pragmatic/bonusWin
          /game_api/games/pragmatic/jackpotWin
          /game_api/games/pragmatic/promoWin
          /game_api/games/pragmatic/endRound
          /game_api/games/pragmatic
        ]
      end

      def whitelisted_path?
        whitelisted_paths.include?(request.path)
      end
    end
  end
end
