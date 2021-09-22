Rails.application.routes.draw do
  resources :users
  get '/landing', to: 'landing#index', as: :landing
  root to: "landing#index"
end
