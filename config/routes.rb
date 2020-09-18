Rails.application.routes.draw do
  resources :quotes
  get 'projects/:id/team_memberships', to: "projects#team_memberships"
  resources :team_memberships, only: [:destroy]
  authenticate :user, ->(user) { user.admin? } do
    root 'pages#developer', as: :admin_authenticated_root
  end
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end
  devise_for :users
  resources :documents, except: [:new, :create, :edit, :update]
  resources :projects, except: [:destroy] do
    resources :team_memberships, only: [:create]
    resources :lists, only: [:new, :create, :index, :update]
    resources :documents, only: [:index, :new, :create, :edit, :update]
  end
  resources :lists, except: [:new, :create, :index, :update] do
    resources :tasks, only: [:new, :create] do
      member do
        get :complete
        get :uncomplete
      end
    end
  end
  resources :tasks, except: [:create, :new] do
    resources :periods, only: [:create, :new]
  end
  resources :notes, only: [:create, :update, :destroy]
  resources :periods, only: [:show, :update, :index] do
    member do
      patch :finish
    end
  end
  get '/promise/', to: 'pages#promise'
  resources :invoices do
    member do
      patch :approve
    end
  end
  resources :users, only: [:edit, :update]
  get 'profile', to: 'pages#profile'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
