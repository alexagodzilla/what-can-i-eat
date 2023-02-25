Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  get "profile", to: "pages#profile", as: :profile do
    resources :ingredients, only: %i[new create edit update]
  end
  resources :recipes, only: %i[index show] do
    resources :bookmarks, only: %i[create]
    resources :reviews, only: %i[create update]
  end
  resources :reviews, only: %i[destroy]
  resources :bookmarks, only: %i[destroy]
  resources :ingredients, only: %i[destroy]
end
