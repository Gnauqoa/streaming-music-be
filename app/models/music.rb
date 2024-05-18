class Music < ApplicationRecord
  has_many :playlist_musics, dependent: :destroy
  has_many :user_liked_musics, dependent: :destroy
  has_many :music_artists, dependent: :destroy
  has_many :artists, through: :music_artists, source: :artist

  def liked_by_user?(user_id)
    user_liked_musics.where(user_id:).exists?
  end
end
