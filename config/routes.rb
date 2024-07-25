Rails.application.routes.draw do
  get 'intermediate/transition'
  get 'prehome/index'
  get 'payments/new'
  get 'checkouts/create'
  devise_for :users
  root to: "prehome#index"

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :shops, only: [:index, :new, :show, :create, :destroy]

  resources :orders, only: [:index, :show] do
    resources :payments, only: [:new]
  end
  resources :products do
    member do
      post 'add_to_cart', to: 'carts#add_item'
    end
  end

  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
    delete 'remove_item/:product_id', to: 'carts#remove_item', as: 'remove_item'
  end

  post 'checkout/create', to: 'checkouts#create', as: 'checkout_create'

  get 'prehome', to: 'prehome#index', as: 'prehome'
end
