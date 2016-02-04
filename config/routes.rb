Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: 'application#home_page', as: :unauth_root
  end

  authenticate :user do
    root to: 'games#index'
    resources :games, only: [:index, :new, :create, :show] do
      post '/move', to: "games#move"
      get '/won', to: "games#won"
      get '/lost', to: "games#lost"
    end
    post '/load_game', to: "games#load_game", as: :load_game
    resources :multiplayer, only: [:show, :create] do 
      get '/opponent-forfeit', to: "multiplayer#opponent_forfeit"
    end
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
