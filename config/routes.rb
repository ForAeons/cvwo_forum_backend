Rails.application.routes.draw do
  resources :posts 
  get '/posts/:post_id/comments', to: 'comments#show_comments_for_post'
  resources :comments
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
