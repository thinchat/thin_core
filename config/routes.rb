ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :rooms, :only => [:index, :update]
      resources :alerts, :only => [:create]
    end
  end

  resources :messages
  resources :rooms do
    member do
      post 'send_log'
      get 'closed'
    end
  end
  resources :guests
  
  mount Resque::Server, :at => "/resque"

  root :to => 'rooms#index'
end
