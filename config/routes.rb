Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
    resources :ingredients
  end

  resources :ingredients
  root 'recipes#index'
end
