class Music < ApplicationRecord
  belongs_to :artist
  has_many :playlist_musics
  has_many :user_likes

  def liked_by_user?(user_id)
    user_likes.where(user_id:).exists?
  end
end
