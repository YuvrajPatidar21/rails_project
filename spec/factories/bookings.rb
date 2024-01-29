FactoryBot.define do
  factory :booking do
    start_date { "2024-01-29" }
    end_date { "2024-02-05" }
    status { "Pending" }
    association :room
    association :user

  end
end
