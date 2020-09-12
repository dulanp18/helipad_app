Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :purchases, only: [ :new, :create, :show, :edit, :update, :destroy ] do
      patch 'accept', to: 'purchases#accept', as: 'accept'
      patch 'decline', to: 'purchases#decline', as: 'decline'
    end
  end

  get 'my_listings', to: 'listings#my_listings', as: 'my_listings'

  resources :purchases, only: [ :index ]


end
