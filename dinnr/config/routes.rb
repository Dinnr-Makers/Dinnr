Rails.application.routes.draw do

  get 'events' => 'events#index'

  resources :events

end
