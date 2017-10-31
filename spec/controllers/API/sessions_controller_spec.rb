require 'rails_helper'
require 'spec_helper'

RSpec.describe SessionsController, type: :controller do
    
    describe 'POST #create' do
        it 'should detect invalid email' do
            FactoryGirl.create(:user, email: 'beepboop@gmail.com', password: '123456')
            post :create, params: {email: 'beepboop@gmail.com', password: '123456'}
            expect(flash[:warning]).to eq("Invalid email or password")
            expect(response).to redirect_to root_url
        end
        
        it 'should detect valid email/password' do
            FactoryGirl.create(:user, email: 'bugs@rubyplus.com', password: '123456')
            post :create, params: {email: 'bugs@rubyplus.com', password: '123456'}
            expect(flash[:notice]).to eq("Login successfully")
            expect(response).to redirect_to login_url
        end
    end
    
    describe 'POST #destroy' do
        it 'should invalidate token' do
            post :destroy
            expect(flash[:notice]).to eq("Logout successfully")
        end
    end
end