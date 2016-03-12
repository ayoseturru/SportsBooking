Rails.application.routes.draw do
  root 'bookings#new'

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
