Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :tools, except: [:destroy, :show]
    resources :bookings, except: [:destroy, :new]
  end
  resources :tools, only: [:destroy, :index, :show]

end
