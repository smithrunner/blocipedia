Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

  resources :wikis, only: [:new, :edit, :create, :show, :destroy]
end
