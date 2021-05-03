Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end

  get 'home/index'

  devise_for :users, controllers: {invitations: 'invitations', sessions: "sessions"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users 
    resources :products 
    resources :coupons
    resources :orders, only: [:index, :show]
  end

  resources :order_items
  get 'cart', to: 'carts#show'
  get 'checkout', to: 'orders#new'
  get 'show_confirmation', to: 'orders#show_confirmation'
  put 'confirmation', to: 'orders#confirmation'

  resources :users
  resources :products, only: [:index, :show]

  get 'users/:id/set_password', to: 'users#set_password', as: :set_password
  put 'users/:id/update_set_password', to: 'users#update_set_password', as: :update_set_password 

  root to: "home#index"
end
