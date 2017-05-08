Rails.application.routes.draw do
  get 'reports/export'

  resources :groups, only: [:index, :new, :create]

  mount ActionCable.server => '/cable'
  root to: 'home#index'
  resources :users do 
    member do 
      get :report
      get :history
    end
  end
  resources :locations, only: [:index, :create] do
    post :queue, on: :collection
  end
  resources :check_ins, only: [:index, :create]
  resources :check_outs, only: [:index, :create]
  post 'authenticate', to: 'authentication#authenticate'
  post 'refresh_token', to: 'authentication#refresh_token'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  get '/current_info', to: 'profile#current_info'
  get '/history_info', to: 'profile#history_info'

  resources :groups, only: [:index, :create, :update]
  resources :reports, only: [:index] do
    collection do
      get :details
      get :detail
      get :get_general, to: 'reports#get_general'
      get :general
    end
  end
end
