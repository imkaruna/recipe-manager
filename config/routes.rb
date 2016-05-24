Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
    resources :ingredients, controller: :recipes
  end

  resources :ingredients, controller: :ingredients
  root 'recipes#index'
end
