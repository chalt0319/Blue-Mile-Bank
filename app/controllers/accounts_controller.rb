class AccountsController < ApplicationController

  def login
    render 'login'
  end

  def create
    if params[:account]  # if the 'create new account' form has been filled out
      @account = Account.new(account_params)
      if @account.save
        @bank = Bank.new(account_id: @account.id)
        @bank.save
        set_session_id
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to '/new'
      end
    else  # if the 'sign in' form has been filled out
      if @account = Account.find_by(name: params[:name])
        if @account.authenticate(params[:password])
          set_session_id
        else
          cannot_find_account
        end
      else
        cannot_find_account
      end
    end
  end

  def checking  # show page to manage money to checking account
    @account = Account.find(params[:id])
    render 'checking'
  end

  def savings  # show page to manage money to savings account
    @account = Account.find(params[:id])
    render 'savings'
  end

  def add_checking  # add to checking account, then redirect to show page
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    manage_money(@account, @bank, "checking", @amount, "+")
  end

  def add_savings  # add to savings account, then redirect to show page
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    manage_money(@account, @bank, "savings", @amount, "+")
  end

  def sub_checking  # sub to checking account, then redirect to show page
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    manage_money(@account, @bank, "checking", @amount, "-")
  end

  def sub_savings  # sub to savings account, then redirect to show page
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    manage_money(@account, @bank, "savings", @amount, "-")
  end

  def checking_history  # show transaction history
    @account = Account.find(params[:id])
    @histories = @account.histories
  end

  def savings_history  # show transaction history
    @account = Account.find(params[:id])
    @histories = @account.histories
  end

  def new
    @account = Account.new
  end

  def show
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:name, :password)
  end

  def set_session_id
    session[:user_id] = @account.id
    redirect_to account_path(@account)
  end

  def cannot_find_account
    flash[:alert] = "We cannot find your account in our system... Please try again."
    redirect_to login_path
  end

  def manage_money(account, bank, type, amount, add_sub)
    if add_sub == "+"
      bank[type] += @amount
      if bank.save
        t = bank.updated_at
        @time = t.strftime("%c")  # translate the time into more readable syntax
        @message = params["message"]
        @history = History.new(account_id: account.id, date: @time, amount: amount, message: @message, add: true)
        @history[type] = true
        bank.save
        @history.save
        redirect_to account_path(account)
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to account_path(account)
      end
    else
      if bank[type] >= @amount
        # if the bank account has more money than the requested amount to be subtracted
        bank[type] -= @amount
        if bank.save
          t = bank.updated_at
          @time = t.strftime("%c")  # translate the time into more readable syntax
          @message = params["message"]
          @history = History.new(account_id: account.id, date: @time, amount: amount, message: @message, add: false)
          @history[type] = true
          bank.save
          @history.save
          redirect_to account_path(account)
        else
          flash[:alert] = "Something's gone wrong... Please try again."
          redirect_to account_path(account)
        end
      else
        flash[:alert] = "Insufficient Funds. Please try again."
        redirect_to account_path(account)
      end
    end
  end

end
