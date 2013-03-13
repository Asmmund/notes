Notes::Application.routes.draw do
  scope 'api' do
    resources :articles
    match 'signup' => 'users#new', via: 'get'
    resources :account,controller: :users, only: [:new, :create]
  end
  match 'signup' => 'users#new', via: 'get'
  resources :main
  root to: 'users#new' #main#index"
  match '/articles*path', to: 'main#index'
  match '/articles', to: 'main#index'

end
