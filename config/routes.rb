Rails.application.routes.draw do
  require 'sidekiq/web'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  root "home#index"
  get 'home/index'
  get 'home/profile', to: 'home#profile', as: 'profile'
  get 'about', to: 'home#about'
  get 'home_service', to: 'home#home_service'
  get 'contact', to: 'home#contact'
  post 'contact', to: 'home#process_contact', as: 'process_contact'
  get 'display_booking', to: 'bookings#display_booking', as: 'display_booking'
  get 'display_payment', to: 'payments#display_payment', as: 'display_payment'
  resources :hotels do 
    resources :room_types
    resources :services
    resources :rooms do
      resources :bookings
    end
  end
  resources :bookings do
    resources :payments, only: [:show, :new, :create]
  end
  get '/bookings/:booking_id/payments/:id/invoice', to: 'payments#invoice', as: 'invoice'
  # resources :room_types
  namespace :admin do
    resources :dashboard, only: [:index]
    get 'new_user', to: 'dashboard#new_user', as: 'dashboard_new_user'
    post 'create_user', to: 'dashboard#create_user', as: 'dashboard_create_user'
    get 'display_user', to: 'dashboard#display_user', as: 'dashboard_display_user'
  end
  namespace :manager do
    resources :dashboard, only: [:index]
    get 'display_user', to: 'dashboard#display_user', as: 'dashboard_display_user'
  end
  namespace :customer do
    resources :dashboard, only: [:index]
  end
end
