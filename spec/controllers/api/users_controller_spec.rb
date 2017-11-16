require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::UsersController, type: :controller do
  def api_login()
    usr = FactoryGirl.create(:user)
    usr.regenerate_token
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(usr.token)
    return usr
  end
    
  describe 'POST #create' do
    it 'should detect duplicate username' do
      FactoryGirl.create(:user, username: 'test1')
      post :create, params: {username: 'test1', email: 'test@gmail.com', password: '123456', displayName: 'test'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should detect duplicate emails' do
      FactoryGirl.create(:user, email: 'test@gmail.com')
      post :create, params: {username: 'test1', email: 'test@gmail.com', password: '123456', displayName: 'test'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
        
    it 'should detect valid username/password' do
      post :create, params: {username: 'test', email: 'test@gmail.com', password: '123456', displayName: 'test'}
      usr = User.find_by_username('test')
      expect(response.body).to include(usr.token)
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'POST #destroy' do
    it 'should delete user account' do
      usr = api_login
      delete :destroy
      expect(response).to have_http_status(:no_content)
    end
  end
end