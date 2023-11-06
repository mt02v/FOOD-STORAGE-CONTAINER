Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root "top#index"
     devise_for :users, controllers: {
       registrations: "users/registrations",
       passwords: "users/passwords"
  }

 get "/index/:genre", to: "items#index"

 resources :users, only: [:show]
 resources :posts
 resources :memos

end

