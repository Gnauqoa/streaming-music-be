# frozen_string_literal: true

class WinLossDetail < ApplicationRecord
  belongs_to :agent, optional: true
  belongs_to :user, optional: true
  belongs_to :bet_result, optional: true
  belongs_to :game_transaction, optional: true
  belongs_to :we_game_transaction, class_name: 'We::GameTransaction', optional: true
  belongs_to :pragmatic_game_transaction, class_name: 'Pragmatic::GameTransaction', optional: true
  belongs_to :we_game, class_name: 'We::Game', optional: true
  belongs_to :game, optional: true

  # TODO: only work if 1 debit = 1 credit
  scope :by_transaction_and_agent_id, lambda { |game_transaction_id, agent_id = nil|
    if agent_id.present?
      where(game_transaction_id:, agent_id:)
    else
      where(game_transaction_id:)
    end
  }
end
