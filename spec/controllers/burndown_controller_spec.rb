require 'rails_helper'

RSpec.describe BurndownController, type: :controller do
  
  describe "index" do
    describe 'when not logged in' do
      before(:each) do
        @proj = FactoryBot.create(:project)
        get :index, params: {id: @proj.id}
      end
      
      it 'should set the flash message' do
        expect(flash[:error]).to eq('Access denied')
      end
      
      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
    
    describe 'when logged in' do
      before(:each) do
        @usr = FactoryBot.create(:user, token: 'beepboop')
        session[:token] = 'beepboop'
        @proj = FactoryBot.create(:project)
        @proj.create_owner(@usr)
        get :index, params: {id: @proj.id}
      end
      
      it 'should assign to project' do
        expect(assigns(:project))
      end
      
      it 'should assign to dates' do
        expect(assigns(:dates))
      end
      
      it 'should assign to data' do
        expect(assigns(:data))
      end
    end
  end

end
