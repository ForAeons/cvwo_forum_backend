Rails.application.routes.draw do
  # get 'posts/latest/:page', to: 'posts#latest'
  resources :posts 
  # get '/posts/:post_id/comments', to: 'comments#show_comments_for_post'
  resources :comments
  post "/signup", to: "users#create"
  post "/login", to: "users#login"
  patch "/users/:id", to: "user#update"
  get "/users/:username", to: "users#show"
  get "/auto_login", to: "users#auto_login"
end
