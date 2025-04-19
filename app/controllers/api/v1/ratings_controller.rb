# app/controllers/api/v1/ratings_controller.rb

module Api
  # Namespace da versão 1 da API
  module V1
    # Controller para ações relacionadas a ratings
    class RatingsController < ApplicationController
      def create
        post = find_post
        return render json: { errors: { post: ['não encontrado'] } }, status: :unprocessable_entity if post.nil?

        rating = post.ratings.build(rating_params)

        if rating.save
          avg = Rating.where(post_id: rating.post_id).average(:value)
          render json: { average_rating: avg.to_f.round(2) }, status: :created
        else
          render json: { errors: combined_errors(post, rating) }, status: :unprocessable_entity
        end
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
