Rails.application.routes.draw do
  # Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Customer authentication
  devise_for :users

  # Public routes
  root "home#index"
  get 'pages/:slug', to: 'pages#show', as: 'page'

  # Products and categories
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  # Shopping cart - add show route
  resources :cart_items, only: [:index, :show, :create, :update, :destroy]

  # Orders and checkout
  resources :orders, only: [:index, :show, :new, :create]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Legacy customer routes (can be removed after migration)
  get "customers/index"
  get "customers/alphabetized", to: "customers#alphabetized", as: :alphabetized_customers
  get "customers/missing_email", to: "customers#missing_email", as: :missing_email_customers
end