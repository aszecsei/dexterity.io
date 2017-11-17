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
      api_login
      post :create, params: {description: 'A project'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should retrieve the appropriate JSON' do
      api_login
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
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :addUser, params: {id: proj.id, rolename:'developer'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a valid username' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {id: proj.id, username: 'test2', rolename:'developer'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a role name' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {id: proj.id, username: 'test2'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should add user to the project as rolename' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      post :addUser, params: {id: proj.id, username: 'test1', rolename:'developer'}
      expect(response).to have_http_status(:no_content)
    end
  end
  
  describe 'POST #edit' do
    it 'should require the user to be logged in' do
      proj = FactoryGirl.create(:project)
      post :addUser, params: {id: proj.id, name: 'second', description: 'from old project'}
      expect(response).to have_http_status(:unauthorized)
    end
    it 'should require a project name and project description' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :edit, params: {id: proj.id}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should require a project name' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :edit, params: {id: proj.id, description: 'from old project'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a project description' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :edit, params: {id: proj.id, name: 'second'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should edit a project with new name and new description' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :edit, params: {id: proj.id, name: 'second', description: 'from old project'}
      expect(response).to have_http_status(:no_content)
    end
  end
  
  describe 'POST #addRole' do
    it 'should require the user to be logged in' do
      proj = FactoryGirl.create(:project)
      post :addRole, params: {id: proj.id, rolename:'developer'}
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should require a role name' do
      usr = api_login
      proj = FactoryGirl.create(:project)
      proj.create_owner(usr)
      post :addRole, params: {id: proj.id}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  
  describe 'POST #assignedRole' do
    it 'should require the user to be logged in' do
      proj = FactoryGirl.create(:project)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      FactoryGirl.create(:role, name:'developer', project_id: proj.id)
      post :assignedRole, params: {id: proj.id, username:'test1', rolename:'developer'}
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should require a valid username' do
      api_login
      proj = FactoryGirl.create(:project)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      FactoryGirl.create(:role, name:'developer', project_id: proj.id)
      post :assignedRole, params: {id: proj.id, username:'test', rolename:'developer'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should require a valid role name' do
      api_login
      proj = FactoryGirl.create(:project)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      FactoryGirl.create(:role, name:'developer', project_id: proj.id)
      post :assignedRole, params: {id: proj.id, username:'test1', rolename:'owner'}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it 'should assign a user to a role' do
      api_login
      proj = FactoryGirl.create(:project)
      FactoryGirl.create(:user, username: 'test1', password: '123456')
      FactoryGirl.create(:role, name:'developer', project_id: proj.id)
      post :assignedRole, params: {id: proj.id, username:'test1', rolename:'developer'}
      expect(response).to have_http_status(:no_content)
    end
  end
end