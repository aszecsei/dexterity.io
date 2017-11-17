require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe 'GET #new' do
       it 'should successfully retrieve the login page' do
           get :new
           expect(response).to render_template :new
       end
    end
    
    describe 'POST #create' do
        it 'should detect invalid tokens' do
            post :create
            expect(response).to redirect_to login_url
        end
        
        it 'should detect valid tokens' do
            FactoryBot.create(:user, token: 'beepboop')
            post :create, params: {token: 'beepboop'}
            expect(response).to redirect_to root_url
            expect(session[:token]).to eq('beepboop')
        end
    end
end
