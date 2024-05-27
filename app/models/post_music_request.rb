class PostMusicRequest < ApplicationRecord
  belongs_to :artist
  enum status: {
    pending: 1,
    rejected: 0,
    approvel: 2
  }
end