class AccountsController < ApplicationController

  def login
    render 'login'
  end

  def create
    if params[:account]
      @account = Account.new(account_params)
      if @account.save
        set_session_id
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to '/new'
      end
    end
  end

  def new
    @account = Account.new
  end

  def show
    @account = Account.find(params[:id])
  end

  private

  def account_params
    params.require(:account).permit(:name, :password)
  end

  def set_session_id
    session[:user_id] = @account.id
    redirect_to account_path(@account)
  end

end
