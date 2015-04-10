Rails.application.routes.draw do
  
  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  
  get '/contact', to: 'static_pages#contact', as: :contact
  
  get 'users/index'

  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'users/show'

  devise_for :users

  resources :answers #only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :events #only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :questions #only: [:index, :show, :new, :create, :edit, :update, :destroy]


end
