Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :youtubes, only: [:new, :create]
  get '/login', to: "application#login"
  root 'youtube#new'
end
