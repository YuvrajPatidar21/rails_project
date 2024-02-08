FactoryBot.define do
  factory :user do
    name { Faker::Name.name}
    email { Faker::Internet.email }
    mobile { Faker::Number.number(digits: 10) }
    address { Faker::Address.street_address }
    city { "Indore" }
    date_of_birth { Faker::Date.birthday(min_age:18, max_age:65) }
    status { "Single" }
    role { "admin" }
    state { "Madhya Pradesh" }
    zipcode { Faker::Number.number(digits:6) }
    password {"123456789"}
  end
end
