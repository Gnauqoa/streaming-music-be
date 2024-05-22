# frozen_string_literal: true

class GameTransaction < ApplicationRecord
  validates_uniqueness_of :txn_id, scope: [:transaction_type, :game_id]
  validates_presence_of :transaction_type, :amount

  has_one :user_record
  belongs_to :user
  belongs_to :game, optional: true

  enum transaction_type: {
    debit: 0,
    credit: 1
  }

  enum status: {
    pending: 0,
    failed: 1,
    paid: 2,
    success: 3,
    cancelled: 4,
    rejected: 5
  }
end
