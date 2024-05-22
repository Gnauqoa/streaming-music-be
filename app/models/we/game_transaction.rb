# frozen_string_literal: true

module We
  def self.table_name_prefix
    'we_'
  end

  class GameTransaction < ApplicationRecord
    validates_uniqueness_of :bet_id, scope: %i[transaction_type game_id]
    validates_presence_of :transaction_type, :amount

    has_one :user_record
    belongs_to :user

    enum transaction_type: {
      debit: 0,
      credit: 1,
      rollback: 2
    }

    enum action_type: {
      bet: 0,
      free_bet: 1,
      transfer_in: 2,
      tip: 3,
      game: 4,
      transfer_out: 5,
      refund: 6,
      free_game: 7,
      bonus_game: 8,
      cancel: 9
    }

    def ref_id
      "WE#{id.to_s.rjust(19, '0')}"
    end
  end
end
