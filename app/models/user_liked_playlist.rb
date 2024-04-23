class UserLikedPlaylist < ApplicationRecord
  belongs_to :user
  belongs_to :playlist
end
