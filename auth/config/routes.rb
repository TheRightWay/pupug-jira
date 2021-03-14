Rails.application.routes.draw do

  use_doorkeeper
  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions'
  }

  root to: 'accounts#index'

  resources :accounts, only: [:index, :edit, :update, :destroy] do
    collection do
      get :current
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
