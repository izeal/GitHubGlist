Rails.application.routes.draw do
  root 'gists#index'

  resources: :gists
end
