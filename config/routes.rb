Rails.application.routes.draw do

  get 'events/new'

  get 'events/create'

  get 'events/update'

  get 'events/edit'

  get 'events/destroy'

  get 'events/show'

  get 'events/index'

  get 'questions/index'

  get 'questions/show'

  get 'questions/new'

  get 'questions/edit'

  get 'questions/update'

  get 'questions/create'

  get 'questions/destroy'

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
