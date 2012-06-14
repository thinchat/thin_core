ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :rooms, :only => [:index, :show, :update]
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

  root :to => 'rooms#index'
end
