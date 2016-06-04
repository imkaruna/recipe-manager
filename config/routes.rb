Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :comments, only: [:index, :new, :create]

  resources :recipes do
    resources :ingredients
  end

  resources :ingredients
  root 'recipes#index'
end
