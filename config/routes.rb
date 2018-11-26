Rails.application.routes.draw do
  root to: "application#home"

  resources :accounts
  get '/login' => 'accounts#login'
  post '/login' => "accounts#create"
  get '/logout' => 'accounts#logout'

end
