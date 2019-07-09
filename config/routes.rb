Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :youtubes, only: [:new, :create]
  get '/oauth2callback', to: "application#oauth2callback"
  get '/login', to: "application#login"
  get '/logout', to: "application#logout"
  root 'youtubes#new'
end
