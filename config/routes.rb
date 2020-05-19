Rails.application.routes.draw do
  namespace :api do
    put 'tasks/switch_user'
  end
  namespace :api do
    get 'users/user_task_list'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
