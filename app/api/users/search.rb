module Users
  class Search < PublicBase
    resources :search do
      desc 'Get user profile', summary: 'Get current user'
      params do
        optional :name, type: String, desc: 'Content name'
        optional :type, type: String, desc: 'music | artist | user'
      end
      get do
        case params[:type]
        when 'music'
          musics = Music.where('name LIKE ?', "%#{params[:name]}%")
          paginated_response(musics)
        when 'artist'
          artists = Artist.where('name LIKE ?', "%#{params[:name]}%")
          paginated_response(artists)
        when 'user'
          users = User.search_by_fullname(params[:name])
          paginated_response(users)
        else
          error!('Invalid type', 422)
        end
      end
    end
  end
end
