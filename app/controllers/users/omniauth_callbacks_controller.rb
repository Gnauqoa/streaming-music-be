# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      handle_oauth
    end

    def google_oauth2
      handle_oauth
    end

    def twitter2
      handle_oauth
    end

    def failure
      render json: failed_response_body('Fail to use OAuth'), status: 422
    end

    private

    def client_id
      request.env.dig('omniauth.params', 'client_id')
    end

    def redirect_path
      request.env.dig('omniauth.params', 'redirect_path')
    end

    def platform
      @platform ||= Platform.find_by(client_id: client_id)
    end

    def handle_oauth
      unless platform
        render json: failed_response_body('Platform must be provided'), status: 422
        return
      end

      @user = User.from_omniauth(request.env['omniauth.auth'], platform)

      if @user.persisted?
        sign_in @user
        redirect_to redirect_path || ENV['OAUTH_REDIRECT_PATH']
      else
        render json: failed_response_body('Fail to use OAuth'), status: 422
      end
    end

    def failed_response_body(object)
      {
        errors: object
      }
    end
  end
end
