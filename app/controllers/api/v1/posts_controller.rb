# app/controllers/api/v1/posts_controller.rb

module Api
  # Namespace da versão 1 da API
  module V1
    # Controller para ações relacionadas a posts
    class PostsController < ApplicationController
      def index
        @posts = Post.all
        render json: @posts
      end

      def create
        job_post = JobPosts.perform_later(user_params:, post_params:)

        if job_post
          render json: { message: 'enviado ao jod' }, status: :accepted
        else
          render json: { message: 'ID JOB - erro ao enviar o job' }, status: :accepted
        end
      end

      def top_posts
        @top_posts = Post.top_posts
        render json: @top_posts.as_json(methods: :avg_rating)
      end

      def authors_ips
        @authors_ips = Post.authors_ips
        render json: @authors_ips
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :ip)
      end

      def user_params
        params.require(:user).permit(:login)
      end

      def combined_errors(user, post)
        errors = {}
        errors.merge!(user.errors.messages) if user.errors.any?
        errors.merge!(post.errors.messages) if post.errors.any?
        errors
      end
    end
  end
end
