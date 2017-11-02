Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  put 'tasks/up/:id' => 'tasks#up_position', as: :up_position
  put 'tasks/down/:id' => 'tasks#down_position', as: :down_position
  put 'tasks/check/:id' => 'tasks#check_task', as: :check_task
end
