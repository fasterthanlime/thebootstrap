Thebootstrap::Application.routes.draw do
  match 'auth/:provider/callback', :to => 'sessions#create'
  match 'auth/failure', :to => 'sessions#failure'
  
  match 'login', :to => 'sessions#new'
  
  resources :events
  
  root :to => 'events#index'
end
