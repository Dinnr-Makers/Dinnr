Rails.application.routes.draw do

  root to: 'events#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }

  get 'events' => 'events#index'
  get 'pictures' => 'pictures#index'

  resources :events do
    resources :reviews
    resources :bookings do
      collection do
        get "leave"
      end
    end
    resource :pictures do
      collection do
        get "library"
      end
    end
  end

  resources :users

  resources :pictures

  resources :eventpictures

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :events do
        get 'map' => 'map#index', :on => :collection
        get 'map' => 'map#show'
      end
    end
  end

  resources :comments, :only => [:create, :destroy]

end