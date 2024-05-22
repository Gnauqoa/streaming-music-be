class AssignedWallet < ApplicationRecord
  belongs_to :user
  has_many :user_transactions

  enum status: {
    pending: 0,
    failed: 1,
    paid: 2,
    success: 3,
    cancelled: 4,
    rejected: 5,
    transferred: 6
  }
end
