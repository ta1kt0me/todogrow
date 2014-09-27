Rails.application.routes.draw do
  get '/tasks/closed', to: 'tasks#closed_index', as: 'closed_tasks'
  resources :tasks
  post '/tasks/:id/close', to: 'tasks#close', as: 'close_task'
  root :to => 'tasks#index'
end
