Rails.application.routes.draw do
  resources :people
  resources :events do
    resources :attendees, controller: 'event_attendees'
    resource :location, controller: 'event_locations'
    collection do
      get :lastest
      post :bulk_delete
      post :bulk_update
    end
    member do
      get :dashboard
      post :join
      post :withdraw
    end
  end
  namespace :admin do
    resources :events
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
