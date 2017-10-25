Rails.application.routes.draw do
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'

  get 'welcome/index'
  root 'welcome#index'
  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/register', to: 'users#new', via: :get
  match '/register', to: 'users#create', via: :post

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
