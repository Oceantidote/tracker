Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    root 'pages#developer', as: :admin_authenticated_root
  end
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end
  root to: 'pages#home'
  resources :invoices
  resources :tasks
  resources :lists
  resources :projects
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
