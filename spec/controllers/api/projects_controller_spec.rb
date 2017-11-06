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
end