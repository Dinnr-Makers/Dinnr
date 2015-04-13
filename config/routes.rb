Rails.application.routes.draw do

  root to: 'events#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }

  get 'events' => 'events#index'
  get 'pictures' => 'pictures#index'

  resources :events do
    resources :bookings do
      collection do
        get "leave"
      end
    end
  end

  resources :users

  resources :pictures

end
