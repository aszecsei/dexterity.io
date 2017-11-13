require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::ProjectsController, type: :controller do
  def api_login()
    usr = FactoryGirl.create(:user)
    usr.regenerate_token
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(usr.token)
    return usr
  end
    
  describe 'POST #create' do
    it 'should require the user to be logged in' do
      post :create, params: {name: 'Project', description: 'A project'}
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should require a name' do
      usr = api_login
      post :create, params: {description: 'A project'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should retrieve the appropriate JSON' do
      usr = api_login
      post :create, params: {name: 'Project', description: 'A project'}
      expect(response.body).to include('Project')
      expect(response.body).to include('A project')
    end
  end
  
  describe 'POST #addUser' do
    it 'should require the user to be logged in' do
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {username: 'test1', rolename:'developer'}
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should require a username' do
      usr = api_login
      post :addUser, params: {rolename:'developer'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a valid username' do
      usr = api_login
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {username: 'test2', rolename:'developer'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a role name' do
      usr = api_login
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {username: 'test2'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should add user to the project as rolename' do
      usr = api_login
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {username: 'test1', rolename:'developer'}
      expect(response).to have_http_status(:no_content)
    end
  end
end