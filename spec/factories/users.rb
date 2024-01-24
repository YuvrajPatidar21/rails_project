FactoryBot.define do
  factory :user do
    name { Faker::Name.name}
    email { Faker::Internet.email }
    mobile { Faker::Number.number(digit: 10) }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    date_of_birth { Faker::Date.birthday(min_age:18, max_age:65) }
  end
end
