Rails.application.routes.draw do
  get '/landing', to: 'landing#index', as: :landing
  root to: "landing#index"
end
