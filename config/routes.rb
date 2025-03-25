Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "about" => "home#about"
  get 'organizer_dashboard', to: 'organizer_dashboard#index'
  root "home#index"

  get "attendee_dashboard/index", to: "attendee_dashboard#index", as: "attendee_dashboard_index"
  get "attendee_dashboard/events", to: "attendee_dashboard#events", as: "attendee_dashboard_events"

  resources :event_registration
  resources :events do
    member do
      post :register_as_listener, to: "event_registration#register_as_listener"
      post :register_as_speaker, to: "event_registration#register_as_speaker"
    end
  end
end
