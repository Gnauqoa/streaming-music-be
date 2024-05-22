# frozen_string_literal: true

module Pragmatic
  def self.table_name_prefix
    'pragmatic_'
  end

  class Game < ApplicationRecord
    def image_url
      return nil if game_id.nil?

      "https://#{ENV['PRAGMATIC_GAME_SERVER_DOMAIN']}/game_pic/rec/325/#{game_id}.png"
    end
    scope :active, -> {}
  end
end
