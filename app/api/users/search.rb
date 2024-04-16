module Users
  class Search < PublicBase
    resources :search do
      desc 'Get user profile', summary: 'Get current user'
      params do
        optional :name, type: String, desc: 'Content name'
        optional :type, type: String, desc: 'music | artist | user'
        optional :page, type: Integer, desc: 'Page number'
        optional :per_page, type: Integer, desc: 'Per page number'
      end
      get do
        case params[:type]
        when 'artist'
          artists = Artist.where('name LIKE ?', "%#{params[:name]}%")
          paginated_response(artists)
        when 'user'
          users = if params[:name].nil?
                    User.order(id: :desc)
                  else
                    User.search_by_fullname(params[:name])
                  end
          paginated_response(users)
        else
          musics = Music.where('name LIKE ?', "%#{params[:name]}%")
          paginated_response(musics) end
      end
    end
  end
end
