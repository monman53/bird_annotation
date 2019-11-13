Rails.application.routes.draw do

  root 'sessions#new'
  get 'sessions/new'

  get 'works/main'
  get 'admins/main'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
