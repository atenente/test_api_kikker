# app/controllers/api/v1/ratings_controller.rb

module Api
  # Namespace da versão 1 da API
  module V1
    # Controller para ações relacionadas a ratings
    class RatingsController < ApplicationController
      def create
        post = find_post
        return render json: { errors: { post: ['não encontrado'] } }, status: :unprocessable_entity if post.nil?

        rating = Rating.new(rating_params)
        return render json: { errors: rating.errors.full_messages }, status: :unprocessable_entity unless rating.valid?

        JobRatings.perform_later(rating_params.to_h)

        render json: { message: 'Rating será processado em segundo plano.' }, status: :accepted
      end

      private

      def rating_params
        params.require(:rating).permit(:post_id, :user_id, :value)
      end

      def find_post
        Post.find_by(user_id: rating_params[:user_id].to_i)
      end

      def combined_errors(post, rating)
        errors = {}
        errors.merge!(post.errors.messages) if post.errors.any?
        errors.merge!(rating.errors.messages) if rating.errors.any?
        errors
      end
    end
  end
end
