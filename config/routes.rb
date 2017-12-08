Rails.application.routes.draw do
  root :to => 'welcome#index'
  
  get 'projects', to: 'projects#index'

  get  '/login'     => 'sessions#new'
  post '/login'     => 'sessions#create'
  get  '/register'  => 'users#new'
  get '/projects/:id' => 'swimlanes#index'
  get '/projects/:id/burndown' => 'burndown#index'
  
  #get  'auth/:provider/callback' => 'sessions#new'
  get 'auth/developer', :as => 'developer_auth'
  match 'auth/:provider/callback' => 'sessions#create', :via => [:get, :post]
  delete 'sign_out', to: "sessions#destroy", as: 'sign_out'

  namespace :api do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
    #get    "auth/:provider/callback"  => "sessions#ocreate"
    match 'auth/:provider/callback' => 'sessions#create', :via => [:get, :post]
    post   "/register"    => "users#create"
    post "/update"        => "users#update"
    delete "/delete"      => "users#destroy"
    post "/password"      => "users#change_password"
    
    get '/project/:id'        => "projects#getProject"
    post '/projects'          => "projects#create"
    post '/adduser/:id'       => "projects#addUser"
    put  '/project/:id'       => "projects#edit"
    delete '/project/:id'     => "projects#destroy"
    post '/addRole/:id'       => "projects#addRole"
    post '/assignedRole/:id'  => "projects#assignedRole"
    
    post '/issues'        => "issues#create"
    post '/issues/reorder'  => "issues#update"
  end
end
