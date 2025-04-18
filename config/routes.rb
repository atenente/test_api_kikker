Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create, :index] do
        collection do
          get :top_posts
          get :authors_ips
        end
      end
      resources :ratings, only: [:create]
    end
  end
end
