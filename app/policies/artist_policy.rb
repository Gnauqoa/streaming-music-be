# frozen_string_literal: true

class ArtistPolicy < ApplicationPolicy
  def manage_music(music_id)
    music = Music.find(music_id)
    music.present? && music.artist == current_artist
  end
end
