Rails.application.routes.draw do

  root 'sessions#new'
  get 'sessions/new'

  get 'works/main'

  post 'works/action'




  get 'admins/main'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #部分テンプレートの部分
  # get 'admins/preprocess'
  # get 'admins/allocation'
  # get 'admins/progress'

  #割り当てしたときのrouting
  post 'admins/create_allocation'


  resources :users
end
