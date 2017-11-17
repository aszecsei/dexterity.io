Rails.application.routes.draw do
  root :to => 'welcome#index'
  
  get 'projects', to: 'projects#index'

  get  '/login'     => 'sessions#new'
  post '/login'     => 'sessions#create'
  get  '/register'  => 'users#new'
  get '/projects/:id' => 'swimlanes#index'
  

  namespace :api do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
    post   "/register"    => "users#create"
    
    post '/projects'       => "projects#create"
    
    post '/issues'        => "issues#create"
    post '/issues/reorder'  => "issues#update"
  end
  #, :format => true, :constraints => { :format => 'json' }
end
