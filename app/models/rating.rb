class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :value, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :post_id }
end
