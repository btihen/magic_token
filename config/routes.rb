Rails.application.routes.draw do
  get '/home',    to: 'home#index',     as: :home
  resources :users
  get '/landing', to: 'landing#index',  as: :landing
  root to: "landing#index"
end
