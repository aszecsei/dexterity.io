require 'spec_helper'
require 'rails_helper'

describe ProjectsController do
    describe 'GET #index' do
        it 'should successfully retrieve the index page' do
            usr = FactoryGirl.create(:user, token: 'beepboop')
            session[:token] = 'beepboop'
            get :index
            expect(response).to render_template :index
        end
       
        it 'should reject users if not logged in' do
            get :index
            expect(flash[:error]).to eq('Access denied')
            expect(response).to redirect_to(login_path)
        end
    end
    describe 'GET #show' do
        it 'should successfully retrieve the project page' do
            usr = FactoryGirl.create(:user, token: 'beepboop')
            session[:token] = 'beepboop'
            get :show, params: {id: '1'}
            expect(assigns(:title)).to eq('Project 1')
            expect(response).to render_template :show
        end
        
        it 'should reject users if not logged in' do
            get :index
            expect(flash[:error]).to eq('Access denied')
            expect(response).to redirect_to(login_path)
        end
    end
end
