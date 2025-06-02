# app/services/rating_service.rb
class RatingService

  def initialize(**kwargs)
    @kwargs = kwargs
    @errors = []
  end

  def self.call(**kwargs)
    new(**kwargs).call
  end

  def call
    run
  end

  private

  def run
    return unless valid_data?(@kwargs)

    rating = @post.ratings.build(user: @user, value: @kwargs['value'])

    unless rating.save
      @erros += rating.errors.full_messages
    end

    Rating.where(post_id: rating.post_id).average(:value)
  end

  def valid_data?(params)
    @user = User.find(params['user_id'])
    @post = Post.find(params['post_id'])
    @user.present? && @post.present?
  end
end
