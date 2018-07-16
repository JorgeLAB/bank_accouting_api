FactoryBot.define do
  factory :account do
    number { Faker::Bank.unique.account_number }
  end
end
