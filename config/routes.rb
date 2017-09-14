Rails.application.routes.draw do
  devise_for :users
    get '/users/sign_out' => 'devise/sessions#destroy'
    
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

  resources :wikis
end
