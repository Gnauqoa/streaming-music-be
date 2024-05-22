# frozen_string_literal: true

class RandomToken < ApplicationRecord
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex
  end
end
