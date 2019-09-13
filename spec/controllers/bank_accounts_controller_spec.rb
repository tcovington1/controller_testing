require 'rails_helper'
require_relative '../support/controller_macros'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let(:valid_attr) {
    { amount: 200, institution: 'Chase', active: true }
  }

  let(:invalid_attr) {
    { amount: 200, institution: '', active: true }
  }
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      bank_account = @user.bank_accounts.create! valid_attr
      get :show, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      bank_account = @user.bank_accounts.create! valid_attr
      get :edit, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'with vaild attr' do
      it 'create a new bank account' do
        expect {
          post :create, params: { bank_account: valid_attr }
        }.to change(BankAccount, :count).by(1)
      end
      
      it 'redirect to the created account' do
        post :create, params: { bank_account: valid_attr }
        expect(reponse).to redirect_to(BankAccount.last)
      end
    end

    context 'with invaild attr' do
      it 'does not create a new account' do
        expect {
          post :create, params: { bank_account: invalid_attr }
        }.to change(BankAccount, :count).by(0)
      end

      it 'redirect to the new form' do
        post :create, params: { bank_account: invalid_attr }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @bank_account = @user.bank_accounts.create! valid_attr
    end
    context 'with valid attr' do

      let(:new_attr) {
        { amount: 220 }
      }

      it 'updates the inputed account' do
        put :update, params: {id: @bank_account.id, bank_account: new_attr}
        @bank_account.reload
        expect(@bank_account.amount).to eq(new_attr[:amount])
      end

      it 'redirect to the updated account' do
        put :update, params: {id: @bank_account.id, bank_account: valid_attr}
        expect(response).to redirect_to(@bank_account)
      end
    end

    context 'with invalid attr' do
      it 'does not update' do
        put :update, params: { id: @bank_account.id, bank_account: invalid_attr }
        @bank_account.reload 
        expect(bank_account.institution).to_not eq(invalid_attr[:institution])
      end

      it 'goes to the edit page' do
        put :update, params: { id: @bank_account.id, bank_account: invalid_attr }
        expect(reponse).to be_successful
      end
    end
  end

  describe 'delete #destroy' do
    before(:each) do
      @bank_account = @user.bank_accounts.create! valid_attr
    end

    it 'delete from database' do
      expect {
        delete :destroy, params: { id: @bank_account.id }
      }.to change(bank_account, :count).by(-1)
    end

    it 'redirect to the url' do
      delete :destroy, params: { id: @bank_account.id }
      expect(reponse).to redirect_to(bank_accounts_url)
    end
  end 

end