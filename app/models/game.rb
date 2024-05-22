# frozen_string_literal: true

class Game < ApplicationRecord
  enum status: {
    active: 0,
    suspended: 1
  }

  scope :active, -> { where(status: :active) }

  belongs_to :game_provider, optional: true
  has_many :games_users
end
