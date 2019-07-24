Rails.application.routes.draw do
 
 devise_for :users

 get "posts/search", to: "posts#search"

 resources :posts do
 	get "pdf",to: "posts#get_pdf"
 	resources :likes, only: [:create,:destroy]
 	resources :comments
 end

 root "posts#index"

end
