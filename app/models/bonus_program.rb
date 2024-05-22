class BonusProgram < ApplicationRecord
  has_many :user_bonus_programs

  enum status: {
    active: 1,
    disabled: 0
  }
  enum frequency: {
    once: 1,
    daily: 2,
    weekly: 3,
    monthly: 4
  }
  enum area: {
    unlimited: 1,
    provider: 2,
    game: 3
  }
  def max_target_turnover
    return nil if deposit_bonus_max.nil? || deposit_bonus_percentage.nil? || turnover.nil? || deposit_bonus_percentage.zero?

    (deposit_bonus_max / deposit_bonus_percentage * 100 + deposit_bonus_max) * turnover
  end
end
