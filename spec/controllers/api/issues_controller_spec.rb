require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::IssuesController, type: :controller do
  before(:each) do
    @usr = FactoryGirl.create(:user)
    @proj = FactoryGirl.create(:project)
    @proj.create_owner(@usr)
  end
  
  def api_login()
    @usr.regenerate_token
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@usr.token)
    return @usr
  end
  
  describe 'POST #create' do
    it 'should require the user to be logged in' do
      post :create, params: {
        name: 'Issue', 
        description: 'An issue', 
        project_id: @proj.id, 
        status_id: @proj.statuses[0].id, 
        category_id: @proj.categories[0].id, 
        estimated_time: "1h30m", 
        story_points: 3 
      }
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should create an issue' do
      api_login
      post :create, params: {
        name: 'My Issue', 
        description: 'An issue', 
        project_id: @proj.id, 
        status_id: @proj.statuses[0].id, 
        category_id: @proj.categories[0].id, 
        estimated_time: "1h 30m",
        story_points: 3 
      }
      
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("My Issue")
      expect(response.body).to include("An issue")
    end
    
    it 'should respond to invalid requests' do
      api_login
      post :create, params: {
        description: 'An issue', 
        project_id: @proj.id, 
        status_id: @proj.statuses[0].id, 
        category_id: @proj.categories[0].id, 
        estimated_time: "1h 30m",
        story_points: 3 
      }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    describe "issue reordering" do
      describe "with a new status" do
        describe "specifying both issues" do
          before(:each) do
            api_login
            post :create, params: {
              name: 'Issue 1',
              description: 'A problem',
              project_id: @proj.id,
              status_id: @proj.statuses[0].id,
              category_id: @proj.categories[0].id,
              estimated_time: "1h 30m",
              story_points: 3
            }
            @id1 = JSON.parse(response.body)["id"]
            post :create, params: {
              name: 'Issue 2',
              description: 'Testing',
              project_id: @proj.id,
              status_id: @proj.statuses[0].id,
              category_id: @proj.categories[0].id,
              estimated_time: "50m",
              story_points: 2
            }
            @id2 = JSON.parse(response.body)["id"]
            post :update, params: {
              prev_id: @id2,
              issue_id: @id1,
              status_id: 0
            }
          end
          it "should return no_content" do
            expect(response).to have_http_status(:no_content)
          end
          it "should re-order the issues" do
            expect(Issue.find_by_id(@id2).next).to eq(Issue.find_by_id(@id1))
          end
        end
      end
    end
  end
end