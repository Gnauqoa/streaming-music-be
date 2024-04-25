class Playlist < ApplicationRecord
  has_many :playlist_musics, dependent: :destroy
  has_many :musics, through: :playlist_musics, dependent: :destroy
  has_many :user_liked_playlists, dependent: :destroy
  belongs_to :user

  def liked_by_user?(user_id)
    user_liked_playlists.where(user_id:).exists?
  end

  def music_ids
    musics.map(&:id)
  end
end
