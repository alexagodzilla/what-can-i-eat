Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  get "profile", to: "pages#profile", as: :profile
  get "profile/bookmarks", to: "bookmarks#index"
  get "profile/ingredients", to: "user_ingredients#index"
  get "profile/friends", to: "pages#friends"
  resources :ingredients, only: %i[create]
  resources :user_ingredients, only: %i[create edit update]
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  resources :recipes, only: %i[index show] do
    resources :bookmarks, only: %i[create]
    resources :reviews, only: %i[create update]
  end
  resources :reviews, :bookmarks, :ingredients, :user_ingredients, only: [:destroy]
end
