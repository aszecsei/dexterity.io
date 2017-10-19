Rails.application.routes.draw do
  get 'projects/index'

  get 'welcome/index'
  root 'welcome#index'
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
