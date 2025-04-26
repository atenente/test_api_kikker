# app/jobs/job_ratings.rb
class JobRatings < ApplicationJob
  queue_as :default

  # adiciona rating
  def perform(rating_params)
    return unless valid_data?(rating_params)

    rating = @post.ratings.build(user: @user, value: rating_params['value'])

    if rating.save
      avg = Rating.where(post_id: rating.post_id).average(:value)
      Rails.logger.info("Average Rating: #{avg.to_f.round(2)}")
    else
      Rails.logger.error("Erros ao salvar rating: #{rating.errors.full_messages}")
    end
  end

  private

  def valid_data?(params)
    @user = User.find(params['user_id'])
    @post = Post.find(params['post_id'])
    @user.present? && @post.present?
  end
end
