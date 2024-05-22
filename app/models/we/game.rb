# frozen_string_literal: true

module We
  def self.table_name_prefix
    'we_'
  end

  class Game < ApplicationRecord
    scope :active, -> { where(is_maintained: false) }
    scope :popular, -> { where(popular: true) }

    belongs_to :we_game_category, class_name: 'We::GameCategory', optional: true
    has_many :we_recent_games, class_name: 'We::RecentGame', foreign_key: 'we_game_id'

    def image_url
      return nil if external_game_id.nil?

      "#{ENV['ASSETS_CDN_URL']}/thumbnails/we-game/#{check_game_id(external_game_id) ? external_game_type : external_game_id}.jpeg"
    end

    def check_game_id(external_game_id)
      load_with_game_type_ids = %w[STUDIO BAB BAMB BASB ZJH BC]
      load_with_game_type_ids.any? { |id| external_game_id.include?(id) }
    end
  end
end
