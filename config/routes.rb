Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  
  root "home#index"
  get 'home/index'
  get 'home/profile', to: 'home#profile', as: 'profile'
  get 'about', to: 'home#about'
  get 'home_service', to: 'home#home_service'
  get 'contact', to: 'home#contact'
  post 'contact', to: 'home#process_contact', as: 'process_contact'
  get 'display_booking', to: 'bookings#display_booking', as: 'display_booking'
  resources :hotels do 
    resources :services
    resources :rooms do
      resources :bookings
    end
  end

  resources :bookings do
    resources :payments, only: [:index, :show, :new, :create]
  end

  resources :room_types
  

  namespace :admin do
    resources :dashboard, only: [:index]
    # get 'dashboard/display_all_booking', to: "dashboard#display_all_booking"
  end
  namespace :manager do
    resources :dashboard, only: [:index]
  end
  namespace :customer do
    resources :dashboard, only: [:index]
  end
end
