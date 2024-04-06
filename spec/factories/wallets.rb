FactoryBot.define do
  factory :wallet do
    address {"0x222"}
      private_key {"0x111"}
      user_id {1}
      currency_id {1}
      wallet_type {'bep20'}
      tracking_id {'1'}
  end
end
