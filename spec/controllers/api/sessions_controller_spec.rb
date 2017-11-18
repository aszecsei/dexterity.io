require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::SessionsController, type: :controller do
    def api_login()
        usr = FactoryBot.create(:user)
        usr.regenerate_token
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(usr.token)
        return usr
    end
    
    describe 'POST #create' do
        it 'should detect invalid username' do
            FactoryBot.create(:user, username: 'test1', password: '123456')
            post :create, params: {username: 'test2', password: '123456'}
            expect(response).to have_http_status(:unauthorized)
        end
        
        it 'should detect valid username/password' do
            FactoryBot.create(:user, username: 'test', password: '123456')
            post :create, params: {username: 'test', password: '123456'}
            expect(response).to have_http_status(:ok)
        end
    end
    
    describe 'POST #destroy' do
        it 'should invalidate token' do
            usr = api_login
            post :destroy
            usr.reload
            expect(usr.token).to be_nil
            expect(response).to have_http_status(:no_content)
        end
        it 'rejects users not logged in' do
            post :destroy
            expect(response).to have_http_status(:unauthorized)
        end
    end
end