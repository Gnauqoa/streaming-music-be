# frozen_string_literal: true

module Pragmatic
  class BetRecordSerializer < ActiveModel::Serializer
    attributes :id, :round_id, :bet_status, :bet_detail_url, :created_at, :updated_at

    belongs_to :user
    belongs_to :pragmatic_game, serializer: GameSerializer
  end
end
