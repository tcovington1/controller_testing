module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create(email: 'test@test.com', password: 'password', 
      first_name: 'Test', last_name: 'Tester', age: 27)
      sign_in @user
    end
  end
end
