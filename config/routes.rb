Rails.application.routes.draw do
  resources :users
  resources :managers
  resources :teams
  resources :responses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
