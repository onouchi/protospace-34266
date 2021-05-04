Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  # get 'prototypes', to: 'prototypes#index'
  
  resources :prototypes do
    resources :comments, only: :create
    # collection do
    #   get 'search'
    # end
  end
  resources :users, only: :show
  
  






  # resources :prototypes, only: :index


end
