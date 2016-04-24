Rails.application.routes.draw do
  resources :comments
  resources :messages do
    collection do
      put "hide_sender"
      put "hide_delivered"
    end
  end
  root 'sessions#welcome'

  resource :session, only: [:new, :create, :destroy] do
    collection do
      get "welcome"
    end
  end

  resources :teams do
    collection do
      put "add_player"
      post "remove_player"
      post "add_players_from_edit"
      post "leave_team"
      post "delete_image_team"
      get "search"
    end
  end

  resources :users do
    collection do
      get 'badge'
      get 'search'
    end
  end


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

  resources :sports do
    collection do
      get 'search'
    end
  end

  resources :installations
end
