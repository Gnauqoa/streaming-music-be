module Users
  class Musics < Base
    resources :musics do
      desc 'Like music'
      params do
        requires :id, type: Integer, desc: 'Music ID'
      end
      post ':id/like' do
        music = Music.find(params[:id])
        return error!([:music_not_found], 401) if music.nil?
        return error!([:music_already_liked], 401) if music.liked_by_user?(current_user.id)

        current_user.user_likes.create!(music:)
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

        current_user.user_likes.find_by(music:).destroy
        music.update(
          likes_count: music.likes_count - 1
        )
        format_response(music, serializer: MusicSerializer, scope: { current_user: })
      end
    end
  end
end
