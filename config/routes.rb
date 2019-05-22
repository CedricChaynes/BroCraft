Rails.application.routes.draw do
  get 'my_profile', to: 'users#my_profile'

  resources :users, only: :update

  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tools, except: [:destroy, :show] do
      collection do
        get 'search'
        get 'filter'
        get 'my_tools', to: "tools#owner_index"
      end
    end
    resources :bookings, except: [:destroy, :new]
  resources :tools, only: [:destroy, :index, :show]
end
