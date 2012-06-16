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
  resources :rooms, :only => [:create, :index]
  resources :logs, :only => [:create]
  match '/rooms/:name/closed' => 'rooms#closed', :as => :closed_room
  match '/rooms/:name' => 'rooms#show', :as => :room

  match 'find' => 'searches#show'
  resources :guests, :only => [:update]
  resources :agents, :only => [:index]
  root :to => 'rooms#index'
  mount Resque::Server, :at => "/resque"

  resources :hangouts
  match '/tos' => 'legal#tos'
  match '/privacy' => 'legal#privacy'
  match '/support' => 'legal#support'

  match '/not_found' => 'errors#not_found', :as => :not_found
end
