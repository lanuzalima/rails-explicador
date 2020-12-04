Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lectures do
    resources :availabilities, only: %i[show new create edit] do
      resources :bookings
    end
  end
  resources :availabilities, only: %i[destroy update]
end
