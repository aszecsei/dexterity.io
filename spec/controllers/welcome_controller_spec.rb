require 'spec_helper'
require 'rails_helper'

describe WelcomeController do
    describe 'GET #index' do
       it 'should successfully retrieve the index page without token' do
           get :index
           expect(response).to render_template :index
       end
       it 'should redirect to projects page with token' do
           FactoryBot.create(:user, token: 'beepboop')
           controller.session[:token] = 'beepboop'
           get :index
           expect(response).to redirect_to projects_url
       end
    end
end
