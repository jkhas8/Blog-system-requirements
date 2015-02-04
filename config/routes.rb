Rails.application.routes.draw do
  root                 'users#login'
  get    'login'    => 'users#login'
  post   'login'    => 'users#create_sessions'
  delete 'logout'   => 'users#logout'
  get    'signup'   => 'users#new'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :entries, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy, :new]
end
