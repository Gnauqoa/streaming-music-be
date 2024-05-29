# frozen_string_literal: true
module V1
  module Artists
    class Artists < PublicBase
      resources :artists do
        after do
          artist = Artist.find_by_email(params[:email])

          log_ip(artist.id, client_ip)
        end
        desc "Sign Up",
            summary: 'Sign Up'
        params do
          requires :email, type: String,
                          desc: 'Email'
          requires :password, type: String, desc: 'The login password'
          requires :password_confirmation, type: String, desc: 'The login password confirmation'
          requires :birth, type: Date, desc: 'The birth date'
          requires :name, type: String, desc: 'The artist name'
        end
        post do
          return error!('Password confirmation does not match', 422) if params[:password] != params[:password_confirmation]
          return error!('Email already exists', 422) if Artist.find_by_email(params[:email])
          artist = Artist.create!(
            email: params[:email],
            password: params[:password],
            birth: params[:birth],
            name: params[:name]
          )

          if artist
            status 201
            generate_token_result = GenerateToken.new(artist:).call
            token = generate_token_result.success
            format_response({ access_token: token })
          else
            error!(failure_response(*@result.failure), 422)
          end
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
end
