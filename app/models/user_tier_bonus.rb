# frozen_string_literal: true

class UserTierBonus < ApplicationRecord
  self.table_name = 'user_tier_bonuses'

  belongs_to :platform
  has_many :plans
  validates_presence_of :transaction_type, :tier, :bonus
  validates :tier, numericality: { greater_than: 0 }
  validates :bonus, numericality: { greater_than: 0 }
  validates :tier, uniqueness: { scope: %i[platform_id transaction_type] }

  # key and value should match with transaction_type of UserTransaction
  # Add to app/models/user_transaction.rb:105
  enum transaction_type: {
    deposit: 0,
    trade: 6,
    buy_nft: 10
  }
end
