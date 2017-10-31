Rails.application.routes.draw do
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'
  
  get 'sessions/new'

  get 'welcome/index'
  root 'welcome#index'
  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/register', to: 'users#new', via: :get
  

  namespace :api do
    match '/login', to: 'sessions#new', via: :get
    post   "/login"       => "sessions#create"
    #delete "/logout"      => "sessions#destroy"
  end
  #, :format => true, :constraints => { :format => 'json' }
end
