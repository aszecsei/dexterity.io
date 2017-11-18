require 'spec_helper'
require 'rails_helper'

describe ApplicationController do
  describe 'Authentication' do
    it 'detect the current user' do
      usr = FactoryBot.create(:user, token: 'beepboop')
      session[:token] = 'beepboop'
      expect(controller.current_user).to eq(usr)
    end
    
    it 'handles required logins' do
      expect(controller).to receive(:handle_unauthorized)
      controller.require_login
    end
  end
end
