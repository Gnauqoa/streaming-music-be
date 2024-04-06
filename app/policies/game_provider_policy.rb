# frozen_string_literal: true

class GameProviderPolicy < ApplicationPolicy
  attr_reader :game_provider, :game

  def initialize(game_provider:, game:)
    @game_provider = game_provider
    @game = game
  end
end
