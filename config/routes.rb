Rails.application.routes.draw do
  resources :tasks
  post '/tasks/:id/close', to: 'tasks#close', as: 'close_task'
  root :to => 'tasks#index'
end
