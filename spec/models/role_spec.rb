require 'rails_helper'
require 'spec_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    FactoryGirl.create(:project, name: 'John Doe')
  end
  it "has a valid factory" do
    FactoryGirl.create(:role, project_id: 1).should be_valid
  end
  it "gets the name of the project correctly" do
    new_role = FactoryGirl.create(:role, project_id: 1)
    expect(new_role.project.name).to eq('John Doe')
  end
end
