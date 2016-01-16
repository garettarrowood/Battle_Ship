Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  unauthenticated do
    root to: 'application#home_page', as: :unauth_root
  end

  authenticate :user do
    root to: 'games#index'
    resources :games do
      post '/move', to: "games#move"
    end
    post '/load_game', to: "games#load_game", as: :load_game
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
