# frozen_string_literal: true

class TelegramAuth < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
