# app/controllers/api/v1/posts_controller.rb

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all
        render json: @posts
      end

      def create
        user = User.find_or_initialize_by(login: user_params[:login])
        post = user.posts.build(post_params)

        if user.save && post.save
          render json: { post: post, user: user }, status: :created
        else
          render json: { errors: combined_errors(user, post) }, status: :unprocessable_entity
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
