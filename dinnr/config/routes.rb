Rails.application.routes.draw do

  devise_for :users
  get 'events' => 'events#index'

  resources :events

  root to: 'events#index'

end
