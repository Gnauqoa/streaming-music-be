class Playlist < ApplicationRecord
  has_many :playlist_musics, dependent: :destroy
  has_many :musics, through: :playlist_musics, dependent: :destroy
  has_many :user_liked_playlists, dependent: :destroy
  belongs_to :user

  def music_ids
    musics.map(&:id)
  end
end
