Cloudspokes::Application.routes.draw do
  root to: 'content#show', id: 'home'
  match "/:id", to: "content#show", as: "content"

  match '/members/index' => 'members#index'
  match "/members/:id" => "members#show"  
  resources :members, :only => [:index, :new, :create, :show]

  get "/challenges/new_reply" => "challenges#new_reply"
  post "/challenges/new_reply" => "challenges#do_new_reply"
  match '/challenges/index' => 'challenges#index'
  post "/challenges/:id" => "challenges#do_new_post_feed"
  match "/challenges/:id" => "challenges#show"
  
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha

  get 'sessions/login'
  get 'sessions/sfdcauth'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'


end
