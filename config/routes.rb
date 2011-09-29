Cloudspokes::Application.routes.draw do
  root to: 'content#show', id: 'home'
  match "/:id", to: "content#show", as: "content"
  
  get 'challenges/index'
  get 'sessions/login'
  get 'sessions/sfdcauth'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'  

end
