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
        it 'should successfully retrieve the project page' do
            get :show, params: {id: '1'}
            expect(assigns(:title)).to eq('Project 1')
            expect(response).to render_template :show
        end
    end
end
