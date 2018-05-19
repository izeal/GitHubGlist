Rails.application.routes.draw do
  root 'gists#index'

  devise_for :users
  resources :gists do
    resources :comments
    post :upvote
    post :downvote
    collection do
      get :resently_created
      get :least_resently_created
      get :resently_updated
      get :least_resently_updated
      # get :popular
    end
  end
  resources :users, only: [:show, :edit, :update]
end
