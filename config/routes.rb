Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
    
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

  resources :wikis
end
