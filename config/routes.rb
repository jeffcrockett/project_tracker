Rails.application.routes.draw do
  get 'bs_page/home'
  root 'application#hello'
end
