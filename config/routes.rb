Rails.application.routes.draw do
  
  post '/users/login', to: 'users#login'
  get '/users/my-page', to: 'users#show'
  patch '/users/my-page', to: 'users#update'
  delete '/notes', to: 'notes#destroy'
  get '/notes/search', to: 'notes#search_index'
  get '/references/search', to: 'references#search'
  patch '/references/save', to: 'references#save'
  patch '/references/remove', to: 'references#remove'

  resources :users, only: [:create]
  resources :notes, only: [:index]
  resources :categories, only: [:index]
  resources :references, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
