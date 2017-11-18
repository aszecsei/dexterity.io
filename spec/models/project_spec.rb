require 'rails_helper'
require 'spec_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.create(:project)).to be_valid
  end
  it "is invalid without a name" do
    expect(FactoryBot.build(:project, name: nil)).to_not be_valid
  end
  it "has access to multiple roles" do
    project1 = FactoryBot.create(:project)
    role1 = FactoryBot.create(:role, name: 'Scrum Master', project: project1)
    role2 = FactoryBot.create(:role, name: 'Project Owner', project: project1)
    expect(project1.roles).to include(role1)
    expect(project1.roles).to include(role2)
  end
  
  it "has access to multiple users" do
    project1 = FactoryBot.create(:project)
    FactoryBot.create(:user, username: 'Liam')
    FactoryBot.create(:user, username: 'Adam')
    FactoryBot.create(:role, name: 'Developer', project_id: 1)
    FactoryBot.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    FactoryBot.create(:workingon, project_id: 1, user_id: 2, role_id: 1)
    expect(project1.users[0].username).to eq('Liam')
    expect(project1.users[1].username).to eq('Adam')
  end
  
  it "can create owners correctly" do
    proj = FactoryBot.create(:project)
    owner = FactoryBot.create(:user)
    proj.create_owner(owner)
    proj.reload
    expect(proj.users[0].username).to eq(owner.username)
  end
  
  it "should be able to access statuses" do
    proj = FactoryBot.create(:project)
    stat = FactoryBot.create(:status, :project => proj)
    expect(proj.statuses.ordered[4]).to eq(stat)
  end
  
  it "should not be able to access statuses of other projects" do
    proj1 = FactoryBot.create(:project)
    proj2 = FactoryBot.create(:project)
    stat1 = FactoryBot.create(:status, :project => proj1)
    stat2 = FactoryBot.create(:status, :project => proj2)
    expect(proj1.statuses).to include(stat1)
    expect(proj1.statuses).to_not include(stat2)
    expect(proj2.statuses).to_not include(stat1)
    expect(proj2.statuses).to include(stat2)
  end
end
