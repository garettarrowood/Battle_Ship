Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  unauthenticated do
    root to: 'application#home_page', as: :unauth_root
  end

  authenticate :user do
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
