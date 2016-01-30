Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
      resources :multiplayer, only: [:index, :create]
    end
    post '/load_game', to: "games#load_game", as: :load_game
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
