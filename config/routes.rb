Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
    resources :ingredients
    resources :ingredients, only: [:destroy], as: :remove, method: 'post'
  end

  resources :ingredients
  root 'recipes#index'
end
