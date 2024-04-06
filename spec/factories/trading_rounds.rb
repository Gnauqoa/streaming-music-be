FactoryBot.define do
  factory :trading_round do
    started_at {Time.zone.now}
    expried_at  {Time.zone.now + 1.minutes}
    duration {60}
    wait_to_next_round {5}
    status     {1}
  end
end
