# Representa os posts do usuario
class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  validates :title, :body, :ip, presence: true
end
