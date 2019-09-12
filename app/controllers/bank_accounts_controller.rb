class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]

  # GET /bank_accounts
  def index
    @bank_accounts = current_user.bank_accounts
  end

  # GET /bank_accounts/1
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = current_user.bank_accounts.new
  end

  # POST /bank_accounts
  def create
    @bank_account = current_user.bank_accounts.new(bank_account_params)
    if @bank_account.save 
      redirect_to @bank_account, notice: 'Bank account was successfully created.'
    else 
      render :new
    end
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # PATCH/PUT /bank_accounts/1
  def update
    if @bank_account.update(bank_account_params)
      redirect_to @bank_account, notice: 'Bank account was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bank_accounts/1
  def destroy
    @bank_account.destroy
    redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed.'
  end

  private
# important to find the current users bank account
    def set_bank_account
      @bank_account = current_user.bank_accounts.find(params[:id])
    end

    def bank_account_params
      params.require(:bank_account).permit(:amount, :institution, :description, :active)
    end
end