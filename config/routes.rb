Thebootstrap::Application.routes.draw do
  match 'auth/:provider/callback', :to => 'sessions#create'
  match 'auth/failure', :to => 'sessions#failure'
  
  match 'login', :to => 'sessions#new'
  
  resources :events do
    resources :attendances
  end
  
  root :to => 'events#index'
end
