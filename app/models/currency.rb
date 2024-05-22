# frozen_string_literal: true

class Currency < ApplicationRecord
  enum status: {
    in_active: 0,
    active: 1
  }

  enum currency_type: {
    coin: 0,
    token: 1,
    erc20: 2,
    bep2: 3,
    bep20: 4,
    coming_soon: 5
  }

  scope :active, -> { where(status: 'active').order(id: :desc) }
end
