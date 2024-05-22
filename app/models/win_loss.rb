# frozen_string_literal: true

class WinLoss < ApplicationRecord
  belongs_to :agent, optional: true
  belongs_to :user, optional: true
end
