class AdminSetting < ApplicationRecord
  enum system_status: {
    in_active: 0,
    active: 1,
    coming_soon: 2,
    maintermance: 3
  }
end
