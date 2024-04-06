FactoryBot.define do
  factory :admin_user do
      email { 'admin@zzl.com' }
      password { SecureRandom.hex[0..12] }
  end
end
