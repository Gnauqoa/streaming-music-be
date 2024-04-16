# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def view_games?
    current_user.present?
  end

  def delete_playlist(playlist_id)
    playlist = Playlist.find(playlist_id)
    playlist.user == current_user
  end
end
