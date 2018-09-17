Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated  do
      root to: 'devise/passwords#new'
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
    end
end
