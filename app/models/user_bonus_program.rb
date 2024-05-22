# frozen_string_literal: true

class UserBonusProgram < ApplicationRecord
  belongs_to :user
  belongs_to :bonus_program
  def completed
    current_turnover >= bonus_program.turnover
  end
end
