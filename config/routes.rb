ThinCore::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index]
    end
  end

  resources :messages
  resources :rooms
  resources :guests

  root :to => 'rooms#index'
end
