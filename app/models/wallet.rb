class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :user_transactions

  after_create :get_block_number

  private

  def get_block_number
    current_block = Wallets::EvmBlockNumber.call()
    self.update(current_block: current_block)
  end
end
