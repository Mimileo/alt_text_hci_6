Rails.application.routes.draw do
  resources :moderators
  resources :alt_texts
  resources :alts, shallow: true do
    resources :alt_texts
  end
  resources :verifcations
  
  
  devise_for :users
  get "verify", to: "alts#verify"
  root "alts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
