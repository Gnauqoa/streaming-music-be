module Users
  class PublicPlaylists < PublicBase
    resources :playlists do
      desc 'List Playlists',
           summary: 'List Playlists'
      params do
        optional :page, type: Integer, desc: 'Page number'
        optional :per_page, type: Integer, desc: 'Per page number'
      end
      get do
        items = Playlist.where(user_id: current_user.id)
        items = items.order(id: :desc)

        paginated_response(items, serializer: UserPlaylistSerializer, scope: { current_user: })
      end

      desc 'Get Playlist',
           summary: 'Get Playlist'
      params do
        requires :id, type: Integer, desc: 'Playlist id'
      end
      get ':id' do
        playlist = Playlist.find(params[:id])
        return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

        format_response(playlist, serializer: PlaylistSerializer, scope: { current_user: })
      end
    end
  end
end
