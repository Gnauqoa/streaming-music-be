FactoryBot.define do
  factory :admin_setting do
    master_wallet { SecureRandom.hex }
    private_key   { SecureRandom.hex }
    system_status {1}
  end
end

