module Users
  class Musics < PublicBase
    resources :musics do
      desc 'Get music'
      params do
        requires :id, type: Integer, desc: 'Music ID'
      end
      get ':id' do
        music = Music.find(params[:id])
        return error!([:music_not_found], 401) if music.nil?

        format_response(music)
      end
    end
  end
end
