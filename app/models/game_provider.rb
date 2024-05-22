# frozen_string_literal: true

class GameProvider < ApplicationRecord
  has_many :games

  enum provider_type: {
    kplay: 0,
    lotto: 1,
    we: 2,
    pragmatic: 3
  }

  scope :active, -> { where(active: true) }
end
