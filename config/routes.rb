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
  get 'projects/delete', to: 'projects#markfordeath'
  get 'projects/:id/delete', to: 'projects#destroy'
  get 'projects/:id/getshift', to: 'projects#getshift'
  get 'projects/:id/:days/:weeks/:months', to: 'projects#doshift'
  get 'projects/review', to: 'projects#review'
  get 'projects/revenue_margin', to: 'projects#revenue_margin'
  get 'projects/cash_flow', to: 'projects#cash_flow'
  get 'projects/filter', to: 'projects#filter'

  get 'registrations/getcompany', to: 'registrations#getcompany'
  get 'registrations/:id/forcompany', to: 'registrations#forcompany'
  get 'registrations/expiration', to: 'registrations#expiration'

  resources :shipments, except: :show
  get 'shipments/delete', to: 'shipments#markfordeath'
  get 'shipments/:id/delete', to: 'shipments#destroy'
  resources :distributors, except: :show
  get 'distributors/delete', to: 'distributors#markfordeath'
  get 'distributors/:id/delete', to: 'distributors#destroy'
  resources :registrations, except: :show
  get 'registrations/delete', to: 'registrations#markfordeath'
  get 'registrations/:id/delete', to: 'registrations#destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root 'home#index'
end