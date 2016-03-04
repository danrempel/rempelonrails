Rails.application.routes.draw do
  devise_for :users
  resources :tags, only: [:index, :show]
  resources :projects
  match '/contact', to: 'contacts#new', via: 'get'
  resources :contacts, only: [:new, :create]
  match '/about', to: 'welcome#index', via: 'get'
  get 'welcome/index'
  root 'posts#index'

  get '*path' => redirect('/')
  resources :posts, path: ""
end
