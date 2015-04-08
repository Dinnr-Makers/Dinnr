Rails.application.routes.draw do

  root to: 'events#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'events' => 'events#index'

  resources :events do
    collection do
      post 'join'
    end
  end

end
