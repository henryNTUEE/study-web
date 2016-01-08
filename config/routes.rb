Rails.application.routes.draw do
  resources :images
  root 'pages#home'
  get 'friends', to: "users#friends"
  get 'arthour', to: 'pages#arthour'
  get 'about', to: 'pages#about' 
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'search_friends', to: "users#search"
  get 'search_articles', to: "articles#search"
  post 'add_friend', to: "users#add_friend"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories
  resources :articles
  resources :users, except: [:new]
  resources :friendships
end
