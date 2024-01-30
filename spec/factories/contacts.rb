FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.paragraph  }
    message { Faker::Lorem.paragraphs }
  end
end
