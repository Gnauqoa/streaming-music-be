class MusicArist < ApplicationRecord
  belongs_to :artist
  belongs_to :music
end
