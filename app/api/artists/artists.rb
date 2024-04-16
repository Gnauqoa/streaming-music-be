# frozen_string_literal: true

module Artists
  class Artists < PublicBase
    resources :artists do
      after do
        artist = Artist.find_by_email(params[:email])

        log_ip(artist.id, client_ip)
      end

      desc 'Sign In',
           summary: 'Sign In'
      params do
        requires :email, type: String,
                         desc: 'Email'
        requires :password, type: String, desc: 'The login password'
      end

      post :sign_in do
        @result = SignIn.new(
          email: params[:email],
          password: params[:password],
          request: env['warden'].request
        ).call

        if @result.success?
          status 200
          format_response({ access_token: @result.success })
        else
          error!(failure_response(*@result.failure), 422)
        end
      end
    end
  end
end
