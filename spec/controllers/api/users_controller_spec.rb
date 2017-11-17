require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #create' do
    it 'should detect duplicate username' do
      FactoryBot.create(:user, username: 'test1')
      post :create, params: {username: 'test1', email: 'test@gmail.com', password: '123456', displayName: 'test'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should detect duplicate emails' do
      FactoryBot.create(:user, email: 'test@gmail.com')
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
end