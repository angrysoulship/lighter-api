Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:create]
      end
      post '/login', to: 'users#login'
      resources :posts, only: [:index, :show, :update, :destroy]
    end
  end
end
