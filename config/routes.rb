Rails.application.routes.draw do
  
  post '/users/login', to: 'users#login'
  get '/users/my-page', to: 'users#show'
  patch '/users/my-page', to: 'users#update'
  delete '/notes', to: 'notes#destroy'
  resources :notes, only: [:index]
  resources :users, only: [:create]
  resources :categories, only: [:index]
  resources :references, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
