ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :rooms, :only => [:index]
    end
  end

  resources :messages
  resources :rooms
  resources :guests

  resource :search, :only => [:show] 

  root :to => 'rooms#index'
end
