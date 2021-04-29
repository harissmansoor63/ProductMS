Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, controllers: { invitations: 'invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users 
    resources :products 
  end

  resources :order_items
  get 'cart', to: 'cart#show'
  get 'checkout', to: 'orders#show'
  get 'confirm', to: 'orders#confirm'

  resources :users
  resources :products, only: [:index, :show]

  get 'users/:id/set_password', to: 'users#set_password', as: :set_password

  put 'users/:id/update_set_password', to: 'users#update_set_password', as: :update_set_password 

  root to: "home#index"
end
