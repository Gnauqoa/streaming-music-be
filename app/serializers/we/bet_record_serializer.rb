# frozen_string_literal: true

module We
  class BetRecordSerializer < ActiveModel::Serializer
    attributes :id, :bet_id, :bet_status, :bet_detail_url, :data, :created_at, :updated_at

    belongs_to :user
    belongs_to :we_game, serializer: GameSerializer
  end
end
