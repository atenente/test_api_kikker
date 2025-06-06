# app/jobs/job_ratings.rb
class JobRatings < ApplicationJob
  queue_as :default

  # verifica possiveis erros
  rescue_from StandardError do |exception|
    Rails.logger.error "Error in MyJob: #{exception.message}"
  end

  # adiciona rating
  def perform(**kwargs)
    RatingService.call(**kwargs)
    raise 'Erro em rating' if erros.any?
  end

end
