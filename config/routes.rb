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
      get 'new_team'
      post 'create_team'
      get 'set_team_id'
      get 'join_team_booking'
      get 'team_bookings'
    end
  end

  resources :time_bands
  resources :sports_installations
  resources :sports
  resources :installations
end
