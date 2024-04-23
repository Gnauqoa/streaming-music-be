# frozen_string_literal: true

module Artists
  class Musics < Base
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
        music = Music.create!(declared(params).merge(artist_id: current_artist.id))
        format_response(music)
      end

      desc 'Update Music',
           summary: 'Update Music'
      params do
        requires :id, type: Integer, desc: 'Music id'
        optional :name, type: String, desc: 'Music name'
        optional :description, type: String, desc: 'Music description'
        optional :thumbnail_url, type: String, desc: 'Music thumbnail url'
        optional :source_url, type: String, desc: 'Music source url'
      end
      put do
        return error!('Music not found', 404) unless ArtistPolicy.new(current_artist:).manage_music(params[:id])

        music = Music.find(params[:id])
        music.update!(declared(params, include_missing: false))
        format_response(music)
      end

      desc 'Delete Music',
           summary: 'Delete Music'
      params do
        requires :id, type: Integer, desc: 'Music id'
      end
      delete do
        return error!('Music not found', 404) unless ArtistPolicy.new(current_artist:).manage_music(params[:id])

        music = Music.find(params[:id])
        music.destroy
        format_response(music)
      end
    end
  end
end
