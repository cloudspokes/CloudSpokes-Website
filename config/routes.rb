Cloudspokes::Application.routes.draw do
  root to: 'content#show', id: 'home'
  match "/:id", to: "content#show", as: "content"

  get 'users/index'
  resources :users, :only => [:index, :new, :create, :show]
  resources :chatters, :only => [:index]

  match 'challenges/index' => 'challenges#index'
  match "/challenges/:id" => "challenges#show"

  get 'sessions/login'
  get 'sessions/sfdcauth'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  get  'chatters/index'

end
