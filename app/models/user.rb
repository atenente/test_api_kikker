# Representa um usuario
class User < ApplicationRecord
  has_many :posts

  validates :login, presence: true, uniqueness: true
end
