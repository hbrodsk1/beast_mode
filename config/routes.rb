Rails.application.routes.draw do
  devise_for :users

  resources :users, :outlets, :comments
end
