# frozen_string_literal: true

module We
  class GameSerializer < ActiveModel::Serializer
    attributes :id, :cn_name, :en_name, :zh_name, :id_name, :th_name, :vi_name, :ko_name, :ja_name, :pt_name, :external_game_id, :external_game_type, :is_maintained, :popular, :created_at,
               :updated_at, :provider

    belongs_to :we_game_category, serializer: We::GameCategorySerializer
  end
end
