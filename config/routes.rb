Rails.application.routes.draw do
  resources :recipes do
    resources :ingredients
  end

  root 'recipes#index'
end
