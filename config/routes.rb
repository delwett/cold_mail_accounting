Rails.application.routes.draw do
  get 'letters/index'

  get 'letters/show'

  get 'letters/new'

  get 'letters/create'

  get 'letters/edit'

  get 'letters/update'

  get 'letters/destroy'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
