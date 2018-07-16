FactoryBot.define do
  factory :credit do
    amount { Faker::Number.decimal(6, 2) }
    account
  end
end
