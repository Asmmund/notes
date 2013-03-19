Notes::Application.routes.draw do

  scope 'api' do
    resources :articles

    resource :account,controller: :users, only: [:new, :create]
    resource :sessions, only: [ :new, :create, :destroy ]
  end

  match 'signup' => 'users#new', via: 'get'
  resource :main
  match 'articles*path', to: 'main#index'
  match 'articles', to: 'main#index'
  match 'signup' , to: 'main#index'
  match 'login', to: 'main#index'
  match 'logout' , to: 'main#index'

  root to: "main#index"

end
