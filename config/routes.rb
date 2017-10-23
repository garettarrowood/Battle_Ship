# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: 'application#home_page', as: :unauth_root
  end

  authenticate :user do
    root to: 'games#index'
    resources :games, only: %i[index new create show] do
      post '/move', to: 'games#move'
      put '/apply_win', to: 'games#apply_win'
      put '/apply_loss', to: 'games#apply_loss'
      get '/won', to: 'games#won'
      get '/lost', to: 'games#lost'
    end
    resources :multiplayer, only: %i[show create] do
      get '/opponent-forfeit', to: 'multiplayer#opponent_forfeit'
    end
    get '/disconnected', to: 'multiplayer#disconnected'
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
