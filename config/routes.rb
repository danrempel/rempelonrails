Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  devise_for :users
  resources :posts
  resources :tags, only: [:index, :show]
  resources :projects
  match '/contact', to: 'contacts#new', via: 'get'
  resources :contacts, only: [:new, :create]
  match '/about', to: 'welcome#index', via: 'get'
  get 'welcome/index'
  root 'posts#index'
  match '/404', :to => 'errors#not_found', :via => :all
  match '/500', :to => 'errors#internal_server_error', :via => :all

  get '*path' => redirect('/')
end
