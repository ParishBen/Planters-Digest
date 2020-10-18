Rails.application.routes.draw do
  get "login", to: 'sessions#new', as: "login"
  post "sessions", to: 'sessions#create'
  get '/', to: 'users#welcome', as: 'welcome'
  delete "sessions", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new", as: "signup"
  
  
  resources :plants do
    resources :logs
    resources :comments, only: [:new, :create, :update, :edit, :destroy]
  end
  resources :users do 
    resources :plants, only: [:show, :index]
  end
  resources :sessions, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
