# frozen_string_literal: true

class BankAccount < ApplicationRecord
  has_one_attached :logo

  belongs_to :bank, optional: true

  enum status: {
    active: 0,
    disabled: 1
  }
end
