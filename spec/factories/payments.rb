FactoryBot.define do
  factory :payment do
    card_holder_name { Faker::Name.name }
    card_number { Faker::Number.number(digits: 16) }
    cvv { Faker::Number.number(digits:3) }
    bank_name { Faker::Bank.name }
    amount { Faker::Number.number(digits:4) }
    payment_date { Date.today}
    association :booking
  end
end
