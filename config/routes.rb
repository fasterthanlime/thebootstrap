Thebootstrap::Application.routes.draw do
  get "events/index"

  get "events/show"

    match 'auth/:provider/callback', :to => 'sessions#create'
    match 'login', :to => 'session#new'

    resources :events

    root :to => 'events#index'
end
