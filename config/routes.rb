Rails.application.routes.draw do
  root 'sessions#new'

  resource :session, only: [:new, :create, :destroy]

  resources :teams do
    collection do
      put "add_player"
    end
  end

  resources :users

  resources :bookings do
    collection do
      get 'installation_options'
      get 'free_hours_table'
      post 'delete_team_from_booking'
    end
  end

  resources :time_bands
  resources :sports_installations
  resources :sports
  resources :installations
end
