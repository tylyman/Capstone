Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'users/show'

  get 'users/index'

  devise_for :users

  root to: "users#index"
end
