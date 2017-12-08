Rails.application.routes.draw do
  root :to => 'welcome#index'
  
  get 'projects', to: 'projects#index'

  get  '/login'     => 'sessions#new'
  post '/login'     => 'sessions#create'
  get  '/register'  => 'users#new'
  get '/projects/:id' => 'swimlanes#index'
  get '/projects/:id/burndown' => 'burndown#index'
  
  get 'auth/:provider/callback', to: "sessions#ocreate"
  delete 'sign_out', to: "sessions#destroy", as: 'sign_out'

  namespace :api do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
    
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
