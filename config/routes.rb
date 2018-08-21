Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :auth, only: :create
      resources :users, only: :create do
        resources :events, only: [:create, :show]
        get 'events', to: 'events#show_events'
      end
      resources :events, only: :index
    end
  end

  get 'account_activation/:token', to: 'account_activations#confirm_email', as: :confirm_email
end
