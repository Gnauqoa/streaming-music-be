# frozen_string_literal: true

module We
  def self.table_name_prefix
    'we_'
  end

  class RecentGame < ApplicationRecord
    belongs_to :we_game, class_name: 'We::Game', foreign_key: 'we_game_id'
    belongs_to :user
  end
end
