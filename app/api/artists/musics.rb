# frozen_string_literal: true

module Artists
  class Musics < PublicBase
    resources :musics do
      desc 'Create Music',
           summary: 'Create Music'
      params do
        requires :name, type: String, desc: 'Music name'
        optional :description, type: String, desc: 'Music description'
        optional :thumbnail_url, type: String, desc: 'Music thumbnail url'
        requires :source_url, type: String, desc: 'Music source url'
      end
      post do
        music = Music.create!(declared(params))
        format_response(music)
      end
    end
  end
end
