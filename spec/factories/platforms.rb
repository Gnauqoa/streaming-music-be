FactoryBot.define do
  factory :platform do
    name { 'Wao Studio' }
    client_id { SecureRandom.hex }
    public_key { OpenSSL::PKey::RSA.new(private_key).public_key.to_s }
    private_key { OpenSSL::PKey::RSA.new(4096).to_s }
    hosts { ['localhost'] }
    scope { %w[wallet nft] }

    trait :admin do
      admin { true }
    end
  end
end
