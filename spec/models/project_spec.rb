require 'rails_helper'
require 'spec_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end
  it "is invalid without a name" do
    expect(FactoryGirl.build(:project, name: nil)).to_not be_valid
  end
  it "has access to multiple roles" do
    project1 = FactoryGirl.create(:project)
    role1 = FactoryGirl.create(:role, name: 'Scrum Master', project: project1)
    role2 = FactoryGirl.create(:role, name: 'Project Owner', project: project1)
    expect(project1.roles).to include(role1)
    expect(project1.roles).to include(role2)
  end
  
  it "has access to multiple users" do
    project1 = FactoryGirl.create(:project)
    FactoryGirl.create(:user, username: 'Liam')
    FactoryGirl.create(:user, username: 'Adam')
    FactoryGirl.create(:role, name: 'Developer', project_id: 1)
    FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    FactoryGirl.create(:workingon, project_id: 1, user_id: 2, role_id: 1)
    expect(project1.users[0].username).to eq('Liam')
    expect(project1.users[1].username).to eq('Adam')
  end
  
  it "can create owners correctly" do
    proj = FactoryGirl.create(:project)
    owner = FactoryGirl.create(:user)
    proj.create_owner(owner)
    proj.reload
    expect(proj.users[0].username).to eq(owner.username)
  end
end
