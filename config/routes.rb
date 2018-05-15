Rails.application.routes.draw do
  root 'gists#index'
  resources :gists
  resources :users, only: [:show, :edit, :update]
end
