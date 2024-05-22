# frozen_string_literal: true

class Bank < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  
  enum status: {
    active: 0,
    disabled: 1
  }
end
