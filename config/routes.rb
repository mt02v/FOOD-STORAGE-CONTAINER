Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root to: "top#index"
     devise_for :users, controllers: {
       registrations: "users/registrations",
       passwords: "users/passwords",
       sessions: "users/sessions"
  }

 get "/index/:genre", to: "items#index"

 resources :users, only: [:show]
 resources :posts
 resources :memos
 devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
 end
end

