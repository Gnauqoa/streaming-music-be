# frozen_string_literal: true

module Pragmatic
  def self.table_name_prefix
    'pragmatic_'
  end

  class GameTransaction < ApplicationRecord
    # validates_uniqueness_of :bet_id, scope: %i[transaction_type game_id]
    validates_presence_of :transaction_type, :amount

    has_one :user_record
    belongs_to :user

    enum transaction_type: {
      debit: 0,
      credit: 1,
      rollback: 2,
      refund: 3,
      bonus_win: 4,
      jackpot_win: 5,
      promo_win: 6,
      adjustment: 7
    }

    # enum action_type: {
    #   bet: 0,
    #   free_bet: 1,
    #   transfer_in: 2,
    #   tip: 3,
    #   game: 4,
    #   transfer_out: 5,
    #   refund: 6,
    #   free_game: 7,
    #   bonus_game: 8,
    #   cancel: 9
    # }
  end
end
