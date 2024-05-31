module V1
  module Users
    class Search < PublicBase
      resources :search do
        desc 'Get user profile', summary: 'Get current user'
        params do
          optional :name, type: String, desc: 'Content name'
          optional :type, type: String, desc: 'music | artist | user | playlist', default: 'music', values: %w[music artist user playlist]
          optional :page, type: Integer, desc: 'Page number'
          optional :per_page, type: Integer, desc: 'Per page number'
          optional :category, type: String, desc: 'Category name', values: %w[hot new]
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
          when 'playlist'
            playlists = Playlist.where('name LIKE ?', "%#{params[:name]}%")
            if params[:category] == 'hot'
              playlists = playlists.order(likes_count: :desc)
            elsif params[:category] == 'new'
              playlists = playlists.order(created_at: :desc)
            end
            paginated_response(playlists)
          else
            musics = Music.where('name LIKE ?', "%#{params[:name]}%")
            if params[:category] == 'hot'
              musics = musics.order(likes_count: :desc)
            elsif params[:category] == 'new'
              musics = musics.order(created_at: :desc)
            end
            paginated_response(musics) end
        end
      end
    end
  end
end