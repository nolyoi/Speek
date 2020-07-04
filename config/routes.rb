Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  notify_to :users

  root 'static#index'
  get '/about' => 'static#about'
  get '/contact' => 'static#contact'

  # User auth/sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/register' => 'users#new'
  match '/auth/:provider/callback', to: 'sessions#omni', via: [:get, :post]

  # Dashboard
  get '/users/dashboard' => 'users#dashboard'

  resources :communities do
    resources :posts, except: [:edit, :update]
  end

  resources :posts, only: [:create]
  
  resources :users do 
    get '/follow' => 'users#follow'
    post '/follow' => 'users#follow'
    resources :posts, except: [:edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
