Rails.application.routes.draw do
  
  post '/users/login', to: 'users#login'
  get '/users/my-page', to: 'users#show'
  patch '/users/my-page', to: 'users#update'
  delete '/notes', to: 'notes#destroy'
  
  get '/notes/search/:offsetId/:searchTerm', to: 'notes#search_index'
  get '/notes/:offsetId', to: 'notes#index'
  get '/references/search/:offsetId/:searchTerm', to: 'references#search'
  get '/references/:offsetId', to: 'references#index'
  patch '/references/save', to: 'references#save'
  patch '/references/remove', to: 'references#remove'

  resources :users, only: [:create]
  resources :categories, only: [:index]
  resources :references, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
