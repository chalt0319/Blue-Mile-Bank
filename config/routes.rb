Rails.application.routes.draw do
  resources :histories
  resources :banks
  root to: "application#home"

  resources :accounts
  get '/login' => 'accounts#login'
  post '/login' => "accounts#create"
  get '/logout' => 'accounts#logout'

  get '/manage/:id/checking' => 'accounts#checking'  # show page to manage money
  get '/manage/:id/savings' => 'accounts#savings'  # show page to manage money

  post '/add_checking/:id' => 'accounts#add_checking', :as => :add_checking  # submit form to add money
  post '/add_savings/:id' => 'accounts#add_savings', :as => :add_savings  # submit form to add money

  post '/sub_checking/:id' => 'accounts#sub_checking', :as => :sub_checking # submit form to sub money
  post '/sub_savings/:id' => 'accounts#sub_savings', :as => :sub_savings # submit form to sub money

  get '/checking_history/:id' => 'accounts#checking_history', :as => :checking_history
  # transaction history for checking account
  get '/savings_history/:id' => 'accounts#savings_history', :as => :savings_history
  # transaction history for savings account



end
