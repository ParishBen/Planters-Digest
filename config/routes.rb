Rails.application.routes.draw do
  get "login", to: 'sessions#new', as: "login"
  post "sessions", to: 'sessions#create'
  get '/', to: 'users#welcome', as: 'welcome'
  delete "/sessions", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new", as: "signup"
  post "/plants/:id", to: "plants#update"
  
  
  resources :comments, only: [:index, :create]
  resources :logs, only: [:new, :index, :create]
  
  resources :plants, shallow: true do
    resources :logs 
    resources :comments
  end
  
  resources :users do 
    resources :plants, only: [:show, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
