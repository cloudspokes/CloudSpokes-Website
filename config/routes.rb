Cloudspokes::Application.routes.draw do
  root to: 'content#show', id: 'home'
  match "/:id", to: "content#show", as: "content"
  
  get "sessions/login"
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'  
end
