# frozen_string_literal: true

module Pragmatic
  def self.table_name_prefix
    'pragmatic_'
  end

  class BetRecord < ApplicationRecord
    validates :round_id, presence: true, uniqueness: true
    belongs_to :user, optional: true
    belongs_to :pragmatic_game, class_name: 'Pragmatic::Game', optional: true

    enum bet_status: {
      pending: 0,
      complete: 1,
      cancel: 2
    }

    attr_accessor :bet_detail_url
  end
end
