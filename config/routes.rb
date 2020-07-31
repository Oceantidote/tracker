Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    root 'pages#developer', as: :admin_authenticated_root
  end
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end
  devise_for :users
  resources :projects, except: [:destroy] do
    resources :lists, only: [:new, :create]
  end
  resources :lists, except: [:new, :create, :destroy] do
    resources :tasks, only: [:create]
  end
  resources :tasks, except: [:create, :new] do
    resources :periods
  end
  resources :invoices
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
