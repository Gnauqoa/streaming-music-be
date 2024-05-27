class PostMusicRequest < ApplicationRecord
  belongs_to :artist
  enum status: {
    pending: 1,
    reject: 0,
    approvel: 2
  }
end