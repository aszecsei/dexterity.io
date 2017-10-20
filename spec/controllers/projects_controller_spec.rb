require 'spec_helper'
require 'rails_helper'

describe ProjectsController do
    describe 'GET #index' do
       it 'should successfully retrieve the index page' do
           get :index
           response.should render_template :index
       end
    end
    
    describe 'GET #show' do
        it 'should successfully retrieve the show page' do
            get :show, params: { id: 1 }
            response.should render_template :show
        end
    end
end
