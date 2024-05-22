# frozen_string_literal: true

class GameBetRecord < ApplicationRecord
  belongs_to :user
  belongs_to :pragmatic_bet_records, class_name: 'Pragmatic::BetRecord', optional: true
  belongs_to :we_bet_records, class_name: 'We::BetRecord', optional: true

  def win_loss_amount
    win_amount - bet_amount
  end

  def provider
    return 'pragmatic' if pragmatic_bet_records_id.present?
    return 'we' if we_bet_records_id.present?

    nil
  end

  def game_data
    return Pragmatic::GameSerializer.new(pragmatic_bet_records.pragmatic_game, {}) if pragmatic_bet_records.present?
    return We::GameSerializer.new(we_bet_records.we_game, {}) if we_bet_records.present?

    nil
  end

  def bet_data
    return  pragmatic_bet_records if pragmatic_bet_records.present?
    return  we_bet_records if we_bet_records.present?

    nil
  end
  
  attr_accessor :bet_detail_url
end
