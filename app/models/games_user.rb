# frozen_string_literal: true

class GamesUser < ApplicationRecord
  belongs_to :game
  belongs_to :user
end
