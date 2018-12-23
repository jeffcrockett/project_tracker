Rails.application.routes.draw do
  resources :products
  resources :projects
  resources :shipments
  resources :distributors
  resources :registrations
  resources :users
  root 'application#hello'
end
