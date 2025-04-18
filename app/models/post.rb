# Representa os posts do usuario
class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, :ip, presence: true
end
