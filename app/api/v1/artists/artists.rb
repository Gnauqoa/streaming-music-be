# frozen_string_literal: true
module V1
  module Artists
    class Artists < PublicBase
      resources :artists do
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

        desc "Sign In",
            summary: 'Sign In'
        params do
          requires :email, type: String,
                          desc: 'Email'
          requires :password, type: String, desc: 'The login password'
        end
        post :sign_in do
          artist = Artist.find_by_email(params[:email])
          return error!('Invalid email or password', 401) unless artist&.valid_password?(params[:password])

          generate_token_result = GenerateToken.new(artist: artist).call
          token = generate_token_result.success
          format_response({ access_token: token })
        end
      end
    
    end
  end
end
