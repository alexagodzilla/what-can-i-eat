Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  get "profile", to: "pages#profile", as: :profile
  resources :ingredients, only: %i[create]
  resources :user_ingredients, only: %i[create edit update]
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  resources :recipes, only: %i[index show] do
    resources :bookmarks, only: %i[create]
    resources :reviews, only: %i[create update]
  end
  resources :reviews, only: %i[destroy]
  resources :bookmarks, only: %i[destroy]
  resources :ingredients, only: %i[destroy]
  resources :user_ingredients, only: %i[destroy]
end
