Rails.application.routes.draw do
  resources :invoices
  resources :tasks
  resources :lists
  resources :projects
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
