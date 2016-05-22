Rails.application.routes.draw do
  resources :recipes do
    resources :ingredients, controller: :recipes do
      post :remove, on: :member
    end
  end
  resources :ingredients
  root 'recipes#index'
end
