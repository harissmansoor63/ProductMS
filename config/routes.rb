Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users 
    resources :products 
  end

  resources :users

  get 'users/:id/set_password', to: 'users#set_password', as: :set_password

  put 'users/:id/update_set_password', to: 'users#update_set_password', as: :update_set_password 

  root to: "home#index"
end
