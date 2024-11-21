Rails.application.routes.draw do
  root to: 'products#index'
  get 'about/index'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  
  resource :cart, only: [:show] do
    post :add_item
    post :remove_item
  end
  
  resources :orders, only: [:create, :show]
  
  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    resources :categories, only: [:index, :new, :create]
  end
end
