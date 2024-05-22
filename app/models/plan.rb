# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :platform
  belongs_to :user_tier_bonus
end
