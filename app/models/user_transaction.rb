# frozen_string_literal: true

class UserTransaction < ApplicationRecord
  validates_uniqueness_of :tx_hash, scope: [:transaction_type]
  validates_presence_of :transaction_type, :amount

  has_one :user_record
  belongs_to :bonus_program, optional: true
  belongs_to :wallet, optional: true
  belongs_to :assigned_wallet, optional: true
  belongs_to :user
  # has_one :assigned_wallet
  has_one :bank_statement
  has_one :crypto_statement

  # after_create :create_record
  before_create :set_tx_hash_random

  # validate :check_erc20_address

  enum transaction_type: {
    deposit: 0,
    withdraw: 1,
    refund: 2,
    bonus: 3
  }

  enum status: {
    pending: 0,
    failed: 1,
    paid: 2,
    success: 3,
    cancelled: 4,
    rejected: 5,
    transferred: 6
  }
  enum reason: {
    payment_not_recived: 0,
    transaction_expired: 1,
    insufficient_funds: 2,
    invalid_amount: 3,
    invalid_account_name: 4,
    invalid_account_number: 5,
    invalid_bank_name: 6,
    invalid_crypto_address: 7,
    account_locked: 8,
    others: 9,
    inavlid_account: 10
  }
  enum payment_method: {
    bank: 0,
    crypto: 1
  }

  private

  def check_erc20_address
    return unless withdraw?

    begin
      address = Eth::Address.new receiver_address
      address.valid?
    rescue StandardError => e
      errors.add(:receiver_address, e)
    end
  end

  def set_tx_hash_random
    self.amount = -amount if amount.positive? && withdraw?
    self.tx_hash = SecureRandom.hex if tx_hash.blank?
  end

  def create_record
    ActiveRecord::Base.transaction do
      balance = user.wallet_balance
      balance += amount

      UserRecord.create!(
        amount:,
        balance:,
        record_type: transaction_type,
        user_id:,
        user_transaction_id: id
      )
    end
  end
end
