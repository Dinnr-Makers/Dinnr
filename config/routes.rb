Rails.application.routes.draw do

  root to: 'events#index'
  get 'map' => 'events#map'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }

  get 'events' => 'events#index'

  resources :events do
    resources :bookings do
      collection do
        get "leave"
      end
    end
  end

  resources :users

end
