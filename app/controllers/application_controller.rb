class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?
  helper_method :current_user_path

  def home
    render "layouts/home"
  end

  def check_current_user  # checks to see if the user is the currently logged in user
    if @account
      if @account.id == session[:user_id]
        true
      else
        false
      end
    else
      if params[:account_id].to_i == session[:user_id]
        true
      else
        false
      end
    end
  end

  def logged_in?  # checks to see if anyone is logged in
    if !!session[:user_id]
      true
    else
      false
    end
  end

  def current_user  # displays the users name in the navbar
    if logged_in?
      if @account = Account.find_by(id: session[:user_id])
        "#{@account.name}'s Profile"
      else
        false
      end
    else
      false
    end
  end

  def current_user_path  # link to the current users home page
    if !!Account.find_by(id: session[:user_id])
      @account = Account.find(session[:user_id])
      account_path(@account)
    end
  end
end
