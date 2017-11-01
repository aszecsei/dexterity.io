Rails.application.routes.draw do
  
  get 'projects/:id', to: 'projects#show'
  get 'projects', to: 'projects#index'

  get 'welcome/index'
  root 'welcome#index'
  get  '/login'     => 'sessions#new'
  post '/login'     => 'sessions#create'
  get  '/register'  => 'users#new'
  
  
  namespace :api, :format => true, :constraints => { :format => 'json' } do
    # routes here
    post '/login' => "sessions#create"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
