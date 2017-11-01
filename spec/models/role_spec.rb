require 'rails_helper'
require 'spec_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    FactoryGirl.create(:project, name: 'John Doe')
  end
  it "has a valid factory" do
    expect(FactoryGirl.create(:role, project_id: 1)).to be_valid
  end
  it "gets the name of the project correctly" do
    new_role = FactoryGirl.create(:role, project_id: 1)
    expect(new_role.project.name).to eq('John Doe')
  end
  it "is invalid without a name" do
    FactoryGirl.build(:role, project_id: 1, name: nil).should_not be_valid
  end
  it "is invalid without a project_id" do
    FactoryGirl.build(:role, project_id: nil).should_not be_valid
  end
  it "should have permissions default to false" do
    new_role1 = FactoryGirl.create(:role, project_id: 1)
    expect(new_role1.add_issues).to eq(false)
    expect(new_role1.close_issues).to eq(false)
  end
  it "should allow permissions to be set to true" do
    new_role2 = FactoryGirl.create(:role, project_id: 1, add_issues: true)
    expect(new_role2.add_issues).to eq(true)
    expect(new_role2.close_issues).to eq(false)
  end
end
