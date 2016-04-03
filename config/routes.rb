Rails.application.routes.draw do
  root 'sessions#new'

  resource :session, only: [:new, :create, :destroy]

  resources :teams do
    collection do
      put "add_player"
      post "remove_player"
      post "add_players_from_edit"
      post "leave_team"
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
      get 'team_bookings_table'
      post 'add_team_to_existing'
      post 'delete_team_from_booking'
      post 'exit_free_booking'
    end
  end

  resources :time_bands
  resources :sports_installations
  resources :sports
  resources :installations
end
