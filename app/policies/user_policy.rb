# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def view_games?
    current_user.present?
  end
end
