FactoryBot.define do
  factory :user_transaction do
    tx_hash {1}
    sender_address {1}
    receiver_address {1}
    amount {1}
    status {1}
    transaction_type {1}
    fee {1}
    memo {1}
    user_id {1}
    currency_id {1}
    wallet_id {1}
  end
end
