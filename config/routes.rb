Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'locations/index'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  resources :check_ins, only: [:index, :create]
  resources :check_outs, only: [:index, :create]
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  resources :locations, only: [:index, :create]
end
