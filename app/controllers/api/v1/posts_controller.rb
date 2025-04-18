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
        posts = Post.joins(:ratings)
                    .select("posts.*, AVG(ratings.value) as avg_rating")
                    .group("posts.id")
                    .order("avg_rating DESC")
                    .limit(10)
        render json: posts.as_json(methods: :avg_rating)
      end

      def authors_ips
        result = Post.joins(:user)
                     .select("DISTINCT posts.ip, users.login")
                     .group_by(&:ip)
                     .map do |ip, grouped_posts|
                       {
                         ip: ip,
                         authors: grouped_posts.map(&:login).uniq
                       }
                     end
        render json: result
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
