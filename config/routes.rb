Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      
      resources :auth, only: :create
      
      resources :users, only: :create
      put 'users/update_user', to: 'users#update_user'

      get 'users/show_events', to: 'users#show_events'
      
      resources :events, only: :create
      
      resources :events, only: [:show, :index] do
        resources :attendees, only: :create
      end

      resources :ticket_details, only: :index
    end
  end

  get 'account_activation/:token', to: 'account_activations#confirm_email', as: :confirm_email
end
