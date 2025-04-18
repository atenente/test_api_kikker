FactoryBot.define do
  factory :rating do
    value { rand(1..5) }
    user_id { post.user_id }
    post_id { post.id }
    association :user
    association :post
  end
end
