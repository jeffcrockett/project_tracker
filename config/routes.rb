Rails.application.routes.draw do
  get 'sessions/new'
  resources :products
  resources :projects
  resources :shipments
  resources :distributors
  resources :registrations
  resources :users
  root 'application#hello'
end
