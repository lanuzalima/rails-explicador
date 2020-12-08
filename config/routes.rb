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
  get '/control_panel', to: 'control_panel#index'
  get '/control_panel/all_my_availabilities', to: 'control_panel#all_my_availabilities'
  get '/control_panel/all_my_bookings', to: 'control_panel#all_my_bookings'
  get '/control_panel/all_my_lectures', to: 'control_panel#all_my_lectures'
end
