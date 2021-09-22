Rails.application.routes.draw do
  resources :logins,      only: [:new, :create]
  # use get to create since I don't think a text url can create a post
  get '/sessions/:token', to: 'sessions#create',  as: :create_session
  resources :sessions,    only: [:destroy]
  get '/home',    to: 'home#index',     as: :home
  resources :users
  get '/landing', to: 'landing#index',  as: :landing
  root to: "landing#index"
end
