# frozen_string_literal: true

module Users
  class Profile < Base
    namespace :users do
      resources :current do
        desc 'Update password for current user', summary: 'Update password'
        params do
          requires :current_password, type: String, desc: 'Current password'
          requires :new_password, type: String, desc: 'New password'
          requires :new_password_confirmation, type: String, desc: 'New password confirmation'
          optional :password_regex, type: String, default: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/, desc: 'Password regex'
        end
        put :password do
          return error!(failure_response(:invalid_current_password), 422) unless current_user.valid_password?(params[:current_password])
          return error!(failure_response(:passwords_do_not_match), 422) unless params[:new_password] == params[:new_password_confirmation]
          return error!(failure_response(:invalid_password), 422) unless params[:new_password] =~ params[:password_regex]

          current_user.password = params[:new_password]
          current_user.save

          format_response(current_user, serializer: UserProfileSerializer)
        end

        desc 'Get user profile', summary: 'Get current user'
        get do
          format_response(current_user, serializer: UserProfileSerializer)
        end

        desc 'Update current user', summary: 'Update current user'
        params do
          optional :first_name, type: String, desc: 'User first name'
          optional :last_name, type: String, desc: 'User last name'
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
