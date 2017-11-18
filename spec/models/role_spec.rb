require 'rails_helper'
require 'spec_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    @proj = FactoryBot.create(:project, name: 'John Doe')
  end
  it "has a valid factory" do
    expect(FactoryBot.create(:role, project_id: 1)).to be_valid
  end
  it "gets the name of the project correctly" do
    new_role = FactoryBot.create(:role, project_id: 1)
    expect(new_role.project.name).to eq('John Doe')
  end
  it "is invalid without a name" do
    expect(FactoryBot.build(:role, project_id: 1, name: nil)).to_not be_valid
  end
  it "is invalid without a project_id" do
    expect(FactoryBot.build(:role, project_id: nil)).to_not be_valid
  end
  it "should have permissions default to false" do
    new_role1 = FactoryBot.create(:role, project_id: 1)
    expect(new_role1.add_issues).to eq(false)
    expect(new_role1.close_issues).to eq(false)
  end
  it "should allow permissions to be set to true" do
    new_role2 = FactoryBot.create(:role, project_id: 1, add_issues: true)
    expect(new_role2.add_issues).to eq(true)
    expect(new_role2.close_issues).to eq(false)
  end
  it "should be able to connect to users" do
    usr = FactoryBot.create(:user, username: 'James')
    role1 = FactoryBot.create(:role, project_id: 1)
    FactoryBot.create(:workingon, project: @proj, user: usr, role: role1)
    expect(role1.users[0].username).to eq('James')
  end
  
  it "should be able to connect to multiple users" do
    usr1 = FactoryBot.create(:user, username: 'James')
    usr2 = FactoryBot.create(:user, username: 'Rebecca')
    role1 = FactoryBot.create(:role, project_id: 1)
    FactoryBot.create(:workingon, project: @proj, user: usr1, role: role1)
    FactoryBot.create(:workingon, project: @proj, user: usr2, role: role1)
    expect(role1.users[0].username).to eq('James')
    expect(role1.users[1].username).to eq('Rebecca')
  end
end
