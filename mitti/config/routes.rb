Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, class_name: 'Users::Admin'
  devise_for :applied_scientists, class_name: 'Users::AppliedScientist'
  devise_for :underwriters, class_name: 'Users::Underwriter'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  root "home#index"

  get 'admin/dashboard' => 'admin#dashboard', as: :admin_dashboard
  get 'applied_scientist/dashboard' => 'applied_scientist#dashboard', as: :applied_science_dashboard
  get 'underwriter/dashboard' => 'underwriter#dashboard', as: :underwriter_dashboard

  resources :observations
  resources :properties
  resources :rules
  #resources :vulnerabilities
end
