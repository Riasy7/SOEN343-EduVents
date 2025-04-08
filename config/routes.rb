Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "about" => "home#about"
  root "home#index"

  get "executive_dashboard", to: "executive_dashboard#index"
  get "executive_dashboard/venues", to: "executive_dashboard#venues"

  get "organizer_dashboard", to: "organizer_dashboard#index"

  get "attendee_dashboard", to: "attendee_dashboard#index"
  get "attendee_dashboard/browse", to: "attendee_dashboard#browse_events"
  get "attendee_dashboard/events", to: "attendee_dashboard#event_registrations"

  resources :event_registration
  resources :events do
    collection do
      get :search
    end
  
    member do
      post :register_as_listener, to: "event_registration#register_as_listener"
      post :register_as_speaker, to: "event_registration#register_as_speaker"
    end
    # nested inside of events
    resources :messages, only: [:index, :create]
  end

  resources :venues

  # stripe checkout routes
  resources :checkouts, only: [ :create ] do
    collection do
      get :success
      get :cancel
    end
  end

  # payment history routes
  resources :users do
    resources :payments, only: [ :index ]
  end
end
