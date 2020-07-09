# frozen_string_literal: true

Rails.application.routes.draw do
  resources :conversations
  resources :messages
  namespace :private do
    end
  notify_to :users

  root 'static#index'
  get '/about' => 'static#about'
  get '/contact' => 'static#contact'

  # User auth/sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/register' => 'users#new'
  match '/auth/:provider/callback', to: 'sessions#omni', via: %i[get post]

  # Dashboard
  get '/users/dashboard' => 'users#dashboard'

  resources :posts, only: [:create]

  namespace :private do 
    resources :conversations
  end

  resources :users do
    get '/follow' => 'users#follow'
    get '/unfollow' => 'users#unfollow'
    resources :posts, except: %i[edit update]
  end

  resources :communities do
    resources :posts, except: %i[edit update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
