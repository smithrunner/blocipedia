Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :users do
    delete "sign_out", :to => "devise/sessions#destroy"
  end
  
  resources :charges, only: [:create, :new, :destroy]
  resources :users, only: [:show]
    
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

  resources :wikis
end
