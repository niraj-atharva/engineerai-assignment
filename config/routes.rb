Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :tweets
  resources :users, only: [:show]
end
