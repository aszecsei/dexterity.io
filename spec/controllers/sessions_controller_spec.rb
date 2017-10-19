require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe 'GET #new' do
       it 'should successfully retrieve the login page' do
           get :new
           response.should render_template :new
       end
    end
end
