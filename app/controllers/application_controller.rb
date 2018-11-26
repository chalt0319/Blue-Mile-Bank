class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?
  helper_method :current_user_path

  def home
    render "layouts/home"
  end

  def check_current_user
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

  def logged_in?
    if !!session[:user_id]
      true
    else
      false
    end
  end

  def current_user
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

  def current_user_path
    if !!Account.find_by(id: session[:user_id])
      @account = Account.find(session[:user_id])
      account_path(@account)
    end
  end
end
