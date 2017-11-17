require 'spec_helper'
require 'rails_helper'

describe ProjectsController do
    describe 'GET #index' do
        it 'should successfully retrieve the index page' do
            usr = FactoryBot.create(:user, token: 'beepboop')
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
end
