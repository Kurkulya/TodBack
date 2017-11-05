Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :lists do
    resources :tasks do
        put 'up' => 'tasks#up_position', as: :up_position
        put 'down' => 'tasks#down_position', as: :down_position
        put 'check' => 'tasks#check', as: :check

      end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end





