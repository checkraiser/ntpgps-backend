Rails.application.routes.draw do
  get 'reports/export'

  mount ActionCable.server => '/cable'
  root to: 'home#index'
  resources :users do 
    member do 
      get :report
    end
  end
  resources :locations, only: [:index, :create]
  resources :check_ins, only: [:index, :create]
  resources :check_outs, only: [:index, :create]
  post 'authenticate', to: 'authentication#authenticate'
  post 'refresh_token', to: 'authentication#refresh_token'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
end
