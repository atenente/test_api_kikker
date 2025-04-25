# Representa os posts do usuario
class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  validates :title, :body, :ip, presence: true

  def self.top_posts
    Post.joins(:ratings)
        .select("posts.*, AVG(ratings.value) as avg_rating")
        .group("posts.id")
        .order("avg_rating DESC")
        .limit(10)
  end

  def self.authors_ips
    Post.joins(:user)
        .select("DISTINCT posts.ip, users.login")
        .group_by(&:ip)
        .map do |ip, grouped_posts|
      { ip: ip, authors: grouped_posts.map(&:login).uniq }
    end
  end
end
