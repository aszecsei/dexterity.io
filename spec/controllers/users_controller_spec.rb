require 'rails_helper'

#create a FactoryGirl model for a user, then check if sending a request to the login controller with that username/password returns properly
#and checking if sending a request with the wrong username/password fails properly

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it 'should successfully retrieve the register page' do
      get :new
      expect(response). to render_template :new
    end
  end
end
