module Users
  class Playlists < Base
    resources :playlists do
      desc 'List Playlists',
           summary: 'List Playlists'
      params do
        optional :page, type: Integer, desc: 'Page number'
        optional :per_page, type: Integer, desc: 'Per page number'
      end
      get do
        items = Playlist.all
        items = items.order(id: :desc)

        paginated_response(items, serializer: PlaylistSerializer)
      end

      desc 'Create Playlist',
           summary: 'Create Playlist'
      params do
        requires :name, type: String, desc: 'Playlist name'
        optional :description, type: String, desc: 'Playlist description'
        optional :thumbnail_url, type: String, desc: 'Playlist thumbnail url'
      end
      post do
        playlist = Playlist.create!(declared(params))
        format_response(playlist)
      end

      desc 'Update Playlist',
           summary: 'Update Playlist'
      params do
        requires :id, type: Integer, desc: 'Playlist id'
        optional :name, type: String, desc: 'Playlist name'
        optional :description, type: String, desc: 'Playlist description'
        optional :thumbnail_url, type: String, desc: 'Playlist thumbnail url'
      end
      put do
        playlist = Playlist.find(params[:id])
        return error!([:playlist_not_found], 401) if playlist.nil?

        playlist.update!(declared(params).except(:id))
        format_response(playlist)
      end

      desc 'Delete Playlist',
           summary: 'Delete Playlist'
      params do
        requires :id, type: Integer, desc: 'Playlist id'
      end
      delete ':id' do
        playlist = Playlist.find(params[:id])
        return error!([:playlist_not_found], 401) if playlist.nil?

        playlist.destroy
        format_response(playlist)
      end

      desc 'Get Playlist',
           summary: 'Get Playlist'
      params do
        requires :id, type: Integer, desc: 'Playlist id'
      end
      get ':id' do
        playlist = Playlist.find(params[:id])
        return error!([:playlist_not_found], 401) if playlist.nil?

        format_response(playlist, serializer: PlaylistSerializer)
      end
    end
  end
end
