Cloudspokes::Application.routes.draw do
  root to: 'content#show', id: 'home'
  match 'leaderboard', :to => 'challenges#leaderboard'
  match "/:id", to: "content#show", as: "content"
  
  get 'challenges/index'
  match 'challenges/:id', :to => 'challenges#detail'
  match 'challenges/:id/registrants', :to => 'challenges#registrants'
  get 'sessions/login'
  get 'sessions/sfdcauth'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'  

end
