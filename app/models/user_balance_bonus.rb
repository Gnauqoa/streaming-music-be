# frozen_string_literal: true

class UserBalanceBonus < ApplicationRecord
  belongs_to :platform
  validates :tier, numericality: { greater_than: 0 }
  validates :bonus, numericality: { greater_than: 0 }
  validates :tier, uniqueness: { scope: %i[platform_id] }
end
