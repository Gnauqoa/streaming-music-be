# frozen_string_literal: true

module Users
  class Profile < Base
    namespace :users do
      resources :current do
        desc 'Get user profile', summary: 'Get current user'
        get do
          format_response(current_user, serializer: UserProfileSerializer)
        end

        desc 'Update current user', summary: 'Update current user'
        params do
          optional :email, type: String, regexp: URI::MailTo::EMAIL_REGEXP,
                           desc: 'The unique login email', documentation: { param_type: 'body' }
          optional :first_name, type: String, desc: 'User first name'
          optional :last_name, type: String, desc: 'User last name'
          optional :current_password, type: String, desc: 'The login password if you want to change password'
          optional :password, type: String, desc: 'The new password'
          optional :avatar, type: File, desc: 'User avatar'
        end
        put do
          result = Update.new(
            user: current_user,
            params: declared(params, include_missing: false)
          ).call

          if result.success?
            format_response(result.success)
          else
            error!(failure_response(*result.failure), 422)
          end
        end
      end
    end
  end
end
