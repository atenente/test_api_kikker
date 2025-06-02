# app/jobs/job_posts.rb
class JobPosts < ApplicationJob
  queue_as :default

  # verifica possiveis erros
  rescue_from StandardError do |exception|
    Rails.logger.error "Error in MyJob: #{exception.message}"
  end

  # adiciona posts
  def perform(**kwargs)
    PostService.call(**kwargs)
    raise 'Erro em posts' if erros.any?
  end
end
