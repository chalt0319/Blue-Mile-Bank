class AccountsController < ApplicationController

  def login
    render 'login'
  end

  def create
    if params[:account]
      @account = Account.new(account_params)
      if @account.save
        @bank = Bank.new(account_id: @account.id)
        @bank.save
        set_session_id
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to '/new'
      end
    else
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

  def add_checking
    render 'checking'
  end

  def checking
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    @bank["checking"] += @amount
    if @bank.save
      t = @bank.updated_at
      @time = t.strftime("%c")
      @bank.checking_history.push("+ $#{@amount} on #{@time}")
      @bank.save
      redirect_to account_path(@account)
    else
      flash[:alert] = "Something's gone wrong... Please try again."
    end
  end

  def add_savings
    render 'savings'
  end

  def savings
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    @bank["savings"] += @amount
    if @bank.save
      t = @bank.updated_at
      @time = t.strftime("%c")
      @bank.savings_history.push("+ $#{@amount} on #{@time}")
      @bank.save
      redirect_to account_path(@account)
    else
      flash[:alert] = "Something's gone wrong... Please try again."
    end
  end

  def sub_checking
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    if @bank["checking"] >= @amount
      @bank["checking"] -= @amount
      if @bank.save
        t = @bank.updated_at
        @time = t.strftime("%c")
        @bank.checking_history.push("- $#{@amount} on #{@time}")
        @bank.save
        redirect_to account_path(@account)
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to account_path(@account)
      end
    else
      flash[:alert] = "Something's gone wrong... Please try again."
      redirect_to account_path(@account)
    end
  end

  def sub_savings
    @account = Account.find(params[:id])
    @bank = Bank.find_by(account_id: params[:id])
    @amount = params["amount"].to_i
    if @bank["savings"] >= @amount
      @bank["savings"] -= @amount
      if @bank.save
        t = @bank.updated_at
        @time = t.strftime("%c")
        @bank.savings_history.push("- $#{@amount} on #{@time}")
        @bank.save
        redirect_to account_path(@account)
      else
        flash[:alert] = "Something's gone wrong... Please try again."
        redirect_to account_path(@account)
      end
    else
      flash[:alert] = "Something's gone wrong... Please try again."
      redirect_to account_path(@account)
    end
  end

  def checking_history
    @bank = Bank.find_by(account_id: params[:id])
    @history = @bank.checking_history
  end

  def savings_history
    @bank = Bank.find_by(account_id: params[:id])
    @history = @bank.savings_history
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

end
