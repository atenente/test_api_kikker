# app/jobs/job_ratings.rb

class JobRatings < ApplicationJob
  queue_as :default

  def perform(rating_params)
    post = Post.find_by(user_id: rating_params["user_id"].to_i)
    return if post.nil?

    rating = post.ratings.build(rating_params)

    if rating.save
      avg = Rating.where(post_id: rating.post_id).average(:value)
      Rails.logger.info("Average Rating: #{avg.to_f.round(2)}")
    else
      Rails.logger.error("Erros ao salvar rating: #{rating.errors.full_messages}")
    end
  end
end
