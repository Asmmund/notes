Notes::Application.routes.draw do

  scope 'api' do
    resources :articles
    match 'signup' => 'users#new', via: 'get'
    resource :account,controller: :users, only: [:new, :create]
  end

  resource :sessions, only: [ :new, :create, :destroy ]
  resource :main
  match '/articles*path', to: 'main#index'
  match '/articles', to: 'main#index'
  match 'signup' => 'users#new', via: :get
  match 'login' => 'sessions#new', via: :get
  match 'logout' => 'sessions#destroy', :via => [:get, :delete]

  root to: "main#index"

end
