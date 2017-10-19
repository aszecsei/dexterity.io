Rails.application.routes.draw do
  
  get 'projects(/:id)', to: 'projects#show'
  get 'projects/index'

  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
