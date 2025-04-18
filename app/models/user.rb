# Representa um usuario
class User < ApplicationRecord
  validates :login, presence: true
end
