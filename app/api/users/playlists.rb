module Users
  class Playlists < Base
    resources :playlists do
      desc 'Add Music to Playlist',
           summary: 'Add Music to Playlist'
      params do
        requires :id, type: Integer, desc: 'Playlist id'
        requires :music_id, type: Integer, desc: 'Music id'
      end
      post ':id/music' do
        playlist = Playlist.find(params[:id])
        return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

        music = Music.find(params[:music_id])
        return error!([:music_not_found], 401) if music.nil?

        return error!([:music_already_in_playlist], 401) if playlist.playlist_musics.where(music_id: music.id).exists?

        playlist.playlist_musics.create!(music_id: music.id)
        format_response(playlist, serializer: PlaylistUserSerializer)
      end

      desc 'List Playlists',
           summary: 'List Playlists'
      params do
        optional :page, type: Integer, desc: 'Page number'
        optional :per_page, type: Integer, desc: 'Per page number'
      end
      get do
        items = Playlist.where(user_id: current_user.id)
        items = items.order(id: :desc)

        paginated_response(items, serializer: PlaylistUserSerializer)
      end

      desc 'Create Playlist',
           summary: 'Create Playlist'
      params do
        requires :name, type: String, desc: 'Playlist name'
        optional :description, type: String, desc: 'Playlist description'
        optional :thumbnail_url, type: String, desc: 'Playlist thumbnail url'
      end
      post do
        playlist = current_user.playlists.create!(declared(params))
        format_response(playlist, serializer: PlaylistUserSerializer)
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
        return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

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
        return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

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
        return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

        format_response(playlist, serializer: PlaylistSerializer)
      end
    end
  end
end
