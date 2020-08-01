Rails.application.routes.draw do
  get 'projects/:id/team_memberships', to: "projects#team_memberships"
  resources :team_memberships, only: [:destroy]
  authenticate :user, ->(user) { user.admin? } do
    root 'pages#developer', as: :admin_authenticated_root
  end
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end
  devise_for :users
  resources :projects, except: [:destroy] do
    resources :team_memberships, only: [:create]
    resources :lists, only: [:new, :create, :index]
  end
  resources :lists, except: [:new, :create, :index] do
    resources :tasks, only: [:create]
  end
  resources :tasks, except: [:create, :new] do
    resources :periods, only: [:create]
  end
  resources :periods, only: [:show, :update, :index] do
    member do
      patch :finish
    end
  end
  resources :invoices
  resources :users, only: [:edit, :update]
  get 'profile', to: 'pages#profile'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
