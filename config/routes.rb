Rails.application.routes.draw do
  get 'home/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :companies, except: :show
  get 'companies/delete', to: 'companies#markfordeath'
  get 'companies/:id/delete', to: 'companies#destroy'
  resources :users, except: :show
  get 'users/delete', to: 'users#markfordeath'
  get 'users/:id/delete', to: 'users#destroy'
  resources :products, except: :show
  get 'products/delete', to: 'products#markfordeath'
  get 'products/:id/delete', to: 'products#destroy'
  resources :projects, except: :show
  resources :shipments
  resources :distributors, except: :show
  resources :registrations, except: :show
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root 'home#index'
end