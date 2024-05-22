# frozen_string_literal: true

class UserRecord < ApplicationRecord
  belongs_to :user_transaction, optional: true
  belongs_to :game_transaction, optional: true
  belongs_to :user

  enum record_type: {
    deposit: 0,
    withdraw: 1,
    debit: 2,
    credit: 3,
    rollback: 4,
    bonus: 5,
    refund: 6,
    bonus_win: 7,
    adjustment: 8
  }

  scope :latest, -> { order(created_at: :desc) }
end
