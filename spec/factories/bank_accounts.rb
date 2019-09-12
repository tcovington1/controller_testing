FactoryBot.define do
  factory :bank_account do
    amount { 1.5 }
    active { false }
    institution { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
