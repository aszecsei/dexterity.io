require 'spec_helper'
require 'rails_helper'

describe ProjectsController do
    describe 'GET #index' do
       it 'should successfully retrieve the index page' do
           get :index
           expect(response).to render_template(:index)
       end
    end
<<<<<<< HEAD
    
    describe 'GET #show' do
        it 'should successfully retrieve the show page' do
            get :show, params: { id: 1 }
            response.should render_template :show
=======
    describe 'GET #show' do
        it 'should successfully retrieve the project page' do
            get :show, params: {id: '1'}
            expect(assigns(:title)).to eq('Project 1')
            expect(response).to render_template :show
>>>>>>> e9fb9db7c1262819b93ebf167316af8890367973
        end
    end
end
