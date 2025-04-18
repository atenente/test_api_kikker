FactoryBot.define do
  factory :user do
    login { Faker::Internet.unique.username }
  end
end
