class Playlist < ApplicationRecord
  has_many :playlist_musics, dependent: :destroy
  has_many :musics, through: :playlist_musics, dependent: :destroy
  has_many :user_liked_playlists, dependent: :destroy
  belongs_to :user

  enum status: {
    show: 1,
    hide: 0
  }
  def image_url
    if object.images.present?
      return object.images[0]['url']
    end
    return "https://i.scdn.co/image/ab67616d0000b27304210aa081c36ce07355679c"
  end
  def liked_by_user?(user_id)
    user_liked_playlists.where(user_id:).exists?
  end

  def music_ids
    musics.map(&:id)
  end
end
