# frozen_string_literal: true

class BankStatement < ApplicationRecord
  belongs_to :user_transaction
  belongs_to :bank_account, optional: true

  enum transaction_type: {
    deposit: 0,
    withdraw: 1
  }

  enum status: {
    pending: 0,
    success: 1,
    failed: 2,
    cancelled: 4
  }
end
