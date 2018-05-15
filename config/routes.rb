Rails.application.routes.draw do
  root 'gists#index'

  devise_for :users
  resources :gists do
    resources :comments
    collection do
      get 'resently_created', to: 'resently_created'
      get 'least_resently_created', to: 'least_resently_created'
      get 'resently_updated', to: 'resently_updated'
      get 'least_resently_updated', to: 'least_resently_updated'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
