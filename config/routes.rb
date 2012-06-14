ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :agents, :onlly => [:index]
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
  
<<<<<<< HEAD
  mount Resque::Server, :at => "/resque"

  match 'find' => 'searches#show'

=======
  resources :guests, :only => [:update]
  resources :agents, :only => [:index]
>>>>>>> 79fc11f0146e0a98769fe91418869a10665362bf
  root :to => 'rooms#index'
  mount Resque::Server, :at => "/resque"
end
