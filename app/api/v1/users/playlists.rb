module V1
  module Users
    class Playlists < Base
      resources :playlists do
        desc 'Like Playlist',
            summary: 'Like Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist ID'
        end
        post ':id/like' do
          playlist = Playlist.find(params[:id])
          return error!([:playlist_not_found], 401) if playlist.nil?

          return error!([:playlist_already_liked], 401) if playlist.liked_by_user?(current_user.id)

          current_user.user_liked_playlists.create!(playlist:)
          playlist.update(
            likes_count: playlist.likes_count + 1
          )
          format_response(playlist, serializer: PlaylistSerializer, scope: { current_user: })
        end
        desc 'Unlike Playlist',
            summary: 'Unlike Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist ID'
        end
        delete ':id/like' do
          user_liked_playlist = current_user.user_liked_playlists.find_by(playlist_id: playlist.id)
          return error!([:playlist_not_liked], 401) if user_liked_playlist.nil?

          user_liked_playlist.destroy
          playlist.update(
            likes_count: playlist.likes_count - 1
          )
          format_response(playlist, serializer: PlaylistSerializer, scope: { current_user: })
        end
        desc 'Remove music from Playlist',
            summary: 'Remove music from Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist id'
          requires :music_id, type: Integer, desc: 'Music id'
        end
        delete ':id/musics' do
          playlist = Playlist.find(params[:id])
          return error!([:playlist_not_found], 401) if playlist.nil? || playlist.user_id != current_user.id

          playlist_music = playlist.playlist_musics.find_by(music_id: params[:music_id])
          return error!([:music_not_in_playlist], 401) if playlist_music.nil?

          playlist_music.destroy
          format_response(playlist, serializer: UserPlaylistSerializer, scope: { current_user: })
        end

        desc 'Add music to Playlist',
            summary: 'Add music to Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist id'
          requires :music_id, type: Integer, desc: 'Music id'
        end
        post ':id/musics' do
          return error!([:playlist_not_found], 401) unless UserPolicy.new(current_user:).manage_playlist(params[:id])

          playlist = Playlist.find(params[:id])

          music = Music.find(params[:music_id])
          return error!([:music_not_valid], 401) if music.nil? || playlist.playlist_musics.where(music_id: music.id).exists?

          playlist.playlist_musics.create!(music_id: music.id)
          format_response(playlist, serializer: UserPlaylistSerializer, scope: { current_user: })
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
          format_response(playlist, serializer: UserPlaylistSerializer, scope: { current_user: })
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
          return error!([:playlist_not_found], 401) unless UserPolicy.new(current_user:).manage_playlist(params[:id])

          playlist = Playlist.find(params[:id])

          playlist.update!(declared(params).except(:id))
          format_response(playlist, serializer: UserPlaylistSerializer, scope: { current_user: })
        end

        desc 'Delete Playlist',
            summary: 'Delete Playlist'
        params do
          requires :id, type: Integer, desc: 'Playlist id'
        end
        delete ':id' do
          return error!([:playlist_not_found], 401) unless UserPolicy.new(current_user:).manage_playlist(params[:id])

          playlist = Playlist.find(params[:id])

          playlist.destroy
          format_response(playlist, serializer: UserPlaylistSerializer, scope: { current_user: })
        end
      end
    end
  end
end