# frozen_string_literal: true

class DepositTier < ApplicationRecord
  def self.find_tier(amount)
    where('min <= ? AND max >= ?', amount, amount).first
  end
end
