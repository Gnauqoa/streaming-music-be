class GameProvidersAgent < ApplicationRecord
  belongs_to :game_provider
  belongs_to :agent

  delegate :name, to: :game_provider, prefix: true

  scope :by_game_provider_id, ->(game_provider_id) { where(game_provider_id: game_provider_id) }
end
