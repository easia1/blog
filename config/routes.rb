Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/articles' => 'articles#index'
  get '/articles/new' => 'articles#new', as: 'new_article'
  post '/articles' => 'articles#create', as: 'create_article'
  # Added this get route for showing single article
  get '/articles/:id' => 'articles#show', as: 'show_article'
  # Added edit route
  get '/articles/:id/edit' => 'articles#edit', as: 'edit_article'
  post '/articles/:id/edit' => 'articles#update', as: 'update_article'
  # Added delete route
  delete '/articles/:id' => 'articles#destroy', as: 'delete_article'
end
