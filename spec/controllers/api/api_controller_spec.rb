require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::ApiController, type: :controller do
  def api_login()
    usr = FactoryGirl.create(:user)
    usr.regenerate_token
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(usr.token)
    return usr
  end
  
  describe 'test require_login' do
    it 'should call authenticate_token' do
      expect(controller).to receive(:authenticate_token)
      allow(controller).to receive(:render)
      controller.require_login
    end
  end
end