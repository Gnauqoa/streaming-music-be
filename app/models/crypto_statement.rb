# frozen_string_literal: true

class CryptoStatement < ApplicationRecord
  belongs_to :user_transaction

  enum transaction_type: {
    deposit: 0,
    withdraw: 1
  }

  enum status: {
    pending: 0,
    success: 1,
    partial_success: 2,
    failed: 3
  }
end
