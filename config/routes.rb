Rails.application.routes.draw do
  namespace :customer do
    get 'dashboard/index'
  end
  namespace :manager do
    get 'dashboard/index'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root "home#index"
  get 'home/index'
  get 'about', to: 'home#about'
  get 'service', to: 'home#service'
  get 'contact', to: 'home#contact'
  post 'contact', to: 'home#process_contact', as: 'process_contact'

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  namespace :manager do
    resources :dashboard, only: [:index]
  end
  namespace :customer do
    resources :dashboard, only: [:index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
