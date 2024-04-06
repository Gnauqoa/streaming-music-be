# frozen_string_literal: true

module Pragmatic
  class GameSerializer < ActiveModel::Serializer
    attributes :id, :game_id, :game_name, :game_type_id, :type_description, :technology, :technology_id, :platform, :demo_game_available, :aspect_ratio, :metadata, :frb_available, :variable_frb_available,
               :lines, :data_type, :created_at, :updated_at, :game_type, :provider, :image_url
  end
end
