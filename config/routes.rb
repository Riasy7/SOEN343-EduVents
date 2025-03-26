Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "about" => "home#about"
  root "home#index"
  
  get "organizer_dashboard", to: "organizer_dashboard#index"

  get "attendee_dashboard", to: "attendee_dashboard#index"
  get "attendee_dashboard/browse", to: "attendee_dashboard#browse_events"
  get "attendee_dashboard/events", to: "attendee_dashboard#event_registrations"

  resources :event_registration
  resources :events do
    member do
      post :register_as_listener, to: "event_registration#register_as_listener"
      post :register_as_speaker, to: "event_registration#register_as_speaker"
    end
  end
end
