require 'spec_helper'
require 'rails_helper'

describe WelcomeController do
    describe 'GET #index' do
       it 'should successfully retrieve the index page' do
           get :index
           response.should render_template :index
       end
    end
end
