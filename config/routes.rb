Rails.application.routes.draw do
  root 'pages#home'
  get 'friends', to: "users#friends"
  get 'arthour', to: 'pages#arthour'
  get 'about', to: 'pages#about' 
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories
  resources :articles
  resources :users, except: [:new]
  resources :friendships
end
