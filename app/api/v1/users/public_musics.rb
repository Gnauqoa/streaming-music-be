module V1
  module Users
    class PublicMusics < PublicBase
      resources :musics do
        desc 'Get music'
        params do
          requires :id, type: Integer, desc: 'Music ID'
        end
        get ':id' do
          music = Music.find_by(id: params[:id])
          return error!([:music_not_found], 404) if music.nil?

          format_response(music, serializer: MusicSerializer, scope: { current_user: })
        end
      end
    end
  end
end