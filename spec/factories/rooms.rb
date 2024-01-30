FactoryBot.define do
  factory :room do
    room_number { "#{ Faker::Number.number(digits:3) }" }
    status {"Available"}
    association :hotel
    association :room_type
  end
end
