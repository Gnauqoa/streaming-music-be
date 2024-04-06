FactoryBot.define do
  factory :user_trade do
    user_id {1}
    currency_id {1}
    trade_type {1}
    trade_value {10}
    trade_at_rate {21000}
    status {0}
  end
end
