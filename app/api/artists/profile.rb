module Artists
  class Profile < Base
    namespace :artists do
      desc 'Update password for current artist', summary: 'Update password'
      params do
        requires :current_password, type: String, desc: 'Current password'
        requires :new_password, type: String, desc: 'New password'
        requires :new_password_confirmation, type: String, desc: 'New password confirmation'
      end
      put :password do
        return error!(failure_response(:invalid_current_password), 422) unless current_artist.valid_password?(params[:current_password])
        return error!(failure_response(:passwords_do_not_match), 422) unless params[:new_password] == params[:new_password_confirmation]

        current_artist.password = params[:new_password]
        current_artist.save

        format_response(current_artist)
      end

      desc 'Get artist profile', summary: 'Get current artist'
      get do
        format_response(current_artist)
      end
    end
  end
end
