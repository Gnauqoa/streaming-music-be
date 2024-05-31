module V1
  module Users
    class PublicPlaylists < PublicBase
      resources :playlists do
        desc 'List Playlists',
            summary: 'List Playlists'
        params do
          optional :page, type: Integer, desc: 'Page number'
          optional :per_page, type: Integer, desc: 'Per page number'
          optional :liked, type: Boolean, desc: 'Get liked playlists', default: false
          optional :name, type: String, desc: 'Playlist name'
        end
        get do
          items = if params[:liked] == true && current_user.present?
                    current_user.liked_playlists
                  else
                    ::Playlist
                  end
          items = items.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
          items = items.order(id: :desc)

          paginated_response(items, serializer: PlaylistSerializer, scope: { current_user: })
        end

        desc 'Get Playlist',
            summary: 'Get Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist id'
        end
        get ':id' do
          playlist = Playlist.find_by(id: params[:id])
          return error!([:playlist_not_found], 404) if playlist.nil? 

          format_response(playlist, serializer: PlaylistSerializer, scope: { current_user: })
        end
      end
    end
  end
end