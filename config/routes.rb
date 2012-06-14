ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :rooms, :only => [:index]
      resources :alerts, :only => [:create]
    end
  end

  resources :messages
  resources :rooms do
    member do
      post 'send_log'
    end
  end
  resources :guests
  
  mount Resque::Server, :at => "/resque"

  match 'find' => 'searches#show'

  root :to => 'rooms#index'
end
