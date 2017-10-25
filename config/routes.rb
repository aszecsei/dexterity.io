Rails.application.routes.draw do
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'

  get 'welcome/index'
  root 'welcome#index'
  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/register', to: 'users#new', via: :get
  
  
  namespace :api, :format => true, :constraints => { :format => 'json' } do
    # routes here
    post '/login' => "sessions#create"
  end

  namespace :api, :format => true, :constraints => { :format => 'json' } do
    post   "/api/login"       => "sessions#create"
    delete "/api/logout"      => "sessions#destroy"
  end
end
