ThinCore::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :messages, :only => [:index, :create]
      resources :users, :only => [:index]
      resources :agents, :only => [:index]
      resources :rooms, :only => [:index]
      resources :alerts, :only => [:create]
      match '/rooms/:name' => 'rooms#update', via: "PUT"
    end
  end

  resources :widget, :only => [:show]
  match '/widget' => 'widget#show'
  resources :messages
  resources :rooms, :only => [:create, :index]
  resources :logs, :only => [:create]
  match '/rooms/:name/closed' => 'rooms#closed', :as => :closed_room
  match '/rooms/:name' => 'rooms#show', :as => :room

  match '/lobby' => 'rooms#index'
  match '/widget_create' => 'rooms#create'

  match 'find' => 'searches#show'
  resources :guests, :only => [:update]
  resources :agents, :only => [:index]
  mount Resque::Server, :at => "/resque"

  resources :hangouts
  match '/tos' => 'legal#tos'
  match '/privacy' => 'legal#privacy'
  match '/support' => 'legal#support'
  match '/not_found' => 'errors#not_found', :as => :not_found
  root :to => 'pages#index'

  match '/dashboard' => 'dashboard#index'
end
