# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def manage_playlist(playlist_id)
    playlist = Playlist.find(playlist_id)
    playlist.present? && playlist.user == current_user
  end
end
