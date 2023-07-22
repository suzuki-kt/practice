Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "relationships/:id/show_follower" => "relationships#show_follower", as: "show_follower"
  get "relationships/:id/show_followee" => "relationships#show_followee", as: "show_followee"
  get "likes/:id" => "likes#show", as: "like"
  delete "likes/:id" => "likes#destroy"
  post "likes/:id" => "likes#create", as: "likes"
  resources :posts
  resources :users
  resources :messages
  resources :chat_rooms
  resources :chat_room_users
  resources :relationships
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
