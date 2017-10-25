Rails.application.routes.draw do
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'

  get 'welcome/index'
  root 'welcome#index'
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  resources :users

  namespace :api, :format => true, :constraints => { :format => 'json' } do
    post   "/api/login"       => "sessions#create"
    delete "/api/logout"      => "sessions#destroy"
  end
end
