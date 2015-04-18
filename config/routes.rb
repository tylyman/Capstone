Rails.application.routes.draw do
  
  root 'static_pages#home'

  put '/enroll/:id', to: 'events#enroll', as: :enroll

  get '/about', to: 'static_pages#about', as: :about
  
  get '/contact', to: 'static_pages#contact', as: :contact

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: [:index, :show]

  resources :questions do
	  resources :answers #only: [:index, :show, :new, :create, :edit, :update, :destroy]
	end
  resources :events #only: [:index, :show, :new, :create, :edit, :update, :destroy]

end
