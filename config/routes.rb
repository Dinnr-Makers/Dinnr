Rails.application.routes.draw do

  root to: 'events#index'
  
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

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :events do
        get 'map' => 'map#index', :on => :collection
        get 'map' => 'map#show'
      end
    end
  end

end
