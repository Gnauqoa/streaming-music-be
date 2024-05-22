# frozen_string_literal: true

class DepositCryptoAddress < ApplicationRecord
  enum status: { active: 0, disabled: 1 }
  enum token: {
    usdt_bep20: 0,
    busd_bep20: 1
  }

  belongs_to :locked_by, class_name: 'User', optional: true

  def locked?
    locked_at.present? && locked_at > 24.hours.ago
  end

  def deposit_message
    if locked?
      locked_by.deposit_message
    else
      ''
    end
  end
end
