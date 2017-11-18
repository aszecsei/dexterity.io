require 'rails_helper'

RSpec.describe SwimlanesController, type: :controller do
        describe 'GET #index' do
            it 'should successfully retrieve the project swimlane' do
                usr = FactoryBot.create(:user, token: 'beepboop')
                session[:token] = 'beepboop'
                proj = FactoryBot.create(:project)
                proj.create_owner(usr)
                get :index, params: {id: proj.id}
                expect(assigns(:title))
                expect(assigns(:categories))
                expect(assigns(:user))
                expect(assigns(:status))
            end
            
            it 'should reject users if not logged in' do
                proj = FactoryBot.create(:project)

                get :index, params: {id: proj.id}
                expect(flash[:error]).to eq('Access denied')
                expect(response).to redirect_to(login_path)
            end
    end
end
