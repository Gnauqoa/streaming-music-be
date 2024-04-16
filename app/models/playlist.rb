class Playlist < ApplicationRecord
  has_many :playlist_musics
  has_many :musics, through: :playlist_musics
  belongs_to :user
end
