Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'home#index'
  resources :users
  resources :locations, only: [:index, :create]
  resources :check_ins, only: [:index, :create]
  resources :check_outs, only: [:index, :create]
  post 'authenticate', to: 'authentication#authenticate'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
end
