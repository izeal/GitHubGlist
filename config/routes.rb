Rails.application.routes.draw do
  devise_for :users
  root 'gists#index'
  resources :gists
  resources :users, only: [:show, :edit, :update]
end
