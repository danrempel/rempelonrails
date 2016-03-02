Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :tags, only: [:index, :show]
  resources :projects
  match '/contact', to: 'contacts#new', via: 'get'
  resources :contacts, only: [:new, :create]
  get 'welcome/index'
  root 'welcome#index'

  get '*path' => redirect('/')
end
