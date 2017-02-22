Rails.application.routes.draw do
  root 'static_pages#rundown'
  devise_for :users

  resources :users, :outlets, :comments
  get 'static_pages/rundown'
end
