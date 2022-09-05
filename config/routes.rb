Rails.application.routes.draw do
  resources :alt_favorites
  get 'favorites/create'
  get 'favorites/destroy'
  get 'favorites/update'
  put '/alts/:id/favorite', to: 'alts#favorite', as: 'favorite'
    put '/alts/:id/unfavorite', to: 'alts#unfavorite', as: 'unfavorite'

  resources :documentations, path: "/documentation"
  resources :abouts, path: "/about"
  resources :moderators
  resources :alt_texts
  resources :alts, shallow: true do
    resources :alt_texts
  end
  # resources :verifcations
  
  
  devise_for :users
  get "verify", to: "alts#verify"
  root "alts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
