Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "about" => "home#about"
  root "home#index"

  resources :event_registration
  resources :events do
    member do
      post :register_as_listener, to: "event_registration#register_as_listener"
      post :register_as_speaker, to: "event_registration#register_as_speaker"
    end
  end
end
