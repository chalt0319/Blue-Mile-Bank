Rails.application.routes.draw do
  resources :banks
  root to: "application#home"

  resources :accounts
  get '/login' => 'accounts#login'
  post '/login' => "accounts#create"
  get '/logout' => 'accounts#logout'

  get '/add/:id/checking' => 'accounts#add_checking'
  post '/add_checking/:id' => 'accounts#checking', :as => :add_checking

  get '/add/:id/savings' => 'accounts#add_savings'
  post '/add_savings/:id' => 'accounts#savings', :as => :add_savings

  post '/sub_checking/:id' => 'accounts#sub_checking', :as => :sub_checking

  post '/sub_savings/:id' => 'accounts#sub_savings', :as => :sub_savings

  get '/checking_history/:id' => 'accounts#checking_history', :as => :checking_history
  get '/savings_history/:id' => 'accounts#savings_history', :as => :savings_history



end
