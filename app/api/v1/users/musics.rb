module V1
  module Users
    class Musics < Base
      resources :musics do
        desc 'Get musics liked',
              summary: 'Get musics liked by user'
        params do
          optional :page, type: Integer, desc: 'Page number'
          optional :per_page, type: Integer, desc: 'Per page number'
        end
        get :liked do
          musics = current_user.liked_musics
          paginated_response(musics, each_serializer: MusicSerializer, scope: { current_user: })
        end
        desc 'Like music'
        params do
          requires :id, type: Integer, desc: 'Music ID'
        end
        post ':id/like' do
          music = Music.find(params[:id])
          return error!([:music_not_found], 401) if music.nil?
          return error!([:music_already_liked], 401) if music.liked_by_user?(current_user.id)

          current_user.user_liked_musics.create!(music:)
          music.update(
            likes_count: music.likes_count + 1
          )
          format_response(music, serializer: MusicSerializer, scope: { current_user: })
        end

        desc 'Unlike music'
        params do
          requires :id, type: Integer, desc: 'Music ID'
        end
        delete ':id/like' do
          music = Music.find(params[:id])
          return error!([:music_not_found], 401) if music.nil?
          return error!([:music_not_liked], 401) unless music.liked_by_user?(current_user.id)

          current_user.user_liked_musics.find_by(music:).destroy
          music.update(
            likes_count: music.likes_count - 1
          )
          format_response(music, serializer: MusicSerializer, scope: { current_user: })
        end
      end
    end
  end
end
