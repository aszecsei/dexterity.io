Rails.application.routes.draw do
  root :to => 'welcome#index'
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'

  get  '/login'     => 'sessions#new'
  post '/login'     => 'sessions#create'
  get  '/register'  => 'users#new'
  

  namespace :api do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
    post   "/register"    => "users#create"
    
    
    post '/projects'      => "projects#create"
    post '/adduser'       => "projects#addUser"
    post '/edit'          => "projects#edit"
    post '/addRole'       => "projects#addRole"
    post '/assignedRole'  => "projects#assignedRole"
    post '/issues'        => "issues#create"
  end
  #, :format => true, :constraints => { :format => 'json' }
end
