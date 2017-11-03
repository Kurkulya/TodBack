Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :v1 do
    resources :lists, except: [:show] do
      resources :tasks, except: [:index, :show]
    end
  end
end
