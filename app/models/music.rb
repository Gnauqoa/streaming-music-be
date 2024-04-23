class Music < ApplicationRecord
  belongs_to :artist
  has_many :playlist_musics, dependent: :destroy
  has_many :liked_musics, dependent: :destroy

  def liked_by_user?(user_id)
    liked_musics.where(user_id:).exists?
  end
end
