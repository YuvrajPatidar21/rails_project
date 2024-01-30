FactoryBot.define do
  factory :booking do
    start_date { Date.today }
    end_date { Date.today + 2.days }
    status { "Pending" }
    association :room
    association :user

  end
end
