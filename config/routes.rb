Rails.application.routes.draw do
  root 'sessions#new'
  resource :session, only: [:new, :create, :destroy]
  resources :teams
  resources :users

  resources :bookings do
    collection do
      get 'installation_options'
      get 'free_hours_table'
    end
  end

  resources :time_bands
  resources :sports_installations
  resources :sports
  resources :installations
end
