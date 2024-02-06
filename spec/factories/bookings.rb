FactoryBot.define do
  factory :booking do
    start_date { Date.today + 10.days }
    end_date { Date.today + 15.days }
    status { "Pending" }
    association :room
    association :user

  end
end
