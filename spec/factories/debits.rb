FactoryBot.define do
  factory :debit do
    amount { Faker::Number.decimal(6, 2) }
    account
  end
end
