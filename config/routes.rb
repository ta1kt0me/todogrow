Rails.application.routes.draw do
  resources :tasks
  get '/tasks/closed', to: 'tasks#closed_index', as: 'closed_tasks'
  post '/tasks/:id/close', to: 'tasks#close', as: 'close_task'
  root :to => 'tasks#index'
end
