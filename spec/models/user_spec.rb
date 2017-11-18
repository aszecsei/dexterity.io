require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.create(:user)).to be_valid
  end
  it "is invalid without a username" do
    expect(FactoryBot.build(:user, username: nil)).to_not be_valid
  end
  it "is invalid without an email" do
    expect(FactoryBot.build(:user, email: nil)).to_not be_valid
  end
  it "is invalid without a display name" do
    expect(FactoryBot.build(:user, displayName: nil)).to_not be_valid
  end
  it "does not allow duplicate usernames" do
    FactoryBot.create(:user, username: 'test')
    expect(FactoryBot.build(:user, username: 'test')).to_not be_valid
  end
  it "does not allow duplicate emails" do
    FactoryBot.create(:user, email: 'test@test.com')
    expect(FactoryBot.build(:user, email: 'test@test.com')).to_not be_valid
  end
  
  it "invalidates tokens" do
    usr = FactoryBot.create(:user, token: 'test')
    expect(usr.token).to eq('test')
    usr.invalidate_token
    usr.reload
    expect(usr.token).to eq(nil)
  end
  
  it "validates successful logins" do
    usr = FactoryBot.create(:user)
    expect(User.valid_login?(usr.username, usr.password)).to be_truthy
  end
  
  it "validates unsuccessful logins" do
    expect(User.valid_login?("test", "test")).to_not be_truthy
  end
  
  it "validates successful tokens" do
    usr = FactoryBot.create(:user, token: 'test')
    expect(User.valid_token?('test')).to be_truthy
  end
  
  it "invalidates unsuccessful tokens" do
    usr = FactoryBot.create(:user, token: 'test')
    expect(User.valid_token?('')).to be_falsey
    expect(User.valid_token?(nil)).to be_falsey
    expect(User.valid_token?('other')).to be_falsey
  end
  
  it "connects to the correct project" do
    user1 = FactoryBot.create(:user)
    FactoryBot.create(:project, name: "John's Helper")
    FactoryBot.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryBot.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    expect(user1.projects[0].name).to eq("John's Helper")
  end
  
  it "connects to the correct role" do
    user1 = FactoryBot.create(:user)
    proj = FactoryBot.create(:project, name: "John's Helper")
    role = FactoryBot.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryBot.create(:workingon, project: proj, user: user1, role: role)
    expect(user1.roles[0].name).to eq('Scrum Master')
  end
  
  it "can connect to multiple projects and roles" do
    user1 = FactoryBot.create(:user)
    FactoryBot.create(:project, name: "John's Helper")
    FactoryBot.create(:project, name: "Ann's Helper")
    FactoryBot.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryBot.create(:role, project_id: 2, name: 'Scrum Master')
    FactoryBot.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    FactoryBot.create(:workingon, project_id: 2, user_id: 1, role_id: 2)
    expect(user1.projects.length).to eq(2)
    expect(user1.roles.length).to eq(2)
  end
  
  it "can properly distinguish projects and roles" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    proj1 = FactoryBot.create(:project, name: "John's Helper")
    proj2 = FactoryBot.create(:project, name: "Ann's Helper")
    role1 = FactoryBot.create(:role, project_id: 1, name: 'Scrum Master')
    role2 = FactoryBot.create(:role, project_id: 2, name: 'Developer')
    role3 = FactoryBot.create(:role, project_id: 1, name: 'Developer')
    role4 = FactoryBot.create(:role, project_id: 2, name: 'Scrum Master')
    FactoryBot.create(:workingon, project: proj1, user: user1, role: role1)
    FactoryBot.create(:workingon, project: proj1, user: user2, role: role3)
    FactoryBot.create(:workingon, project: proj2, user: user1, role: role2)
    FactoryBot.create(:workingon, project: proj2, user: user2, role: role4)
    expect(user1.projects[0].name).to eq("John's Helper")
    expect(user1.projects[1].name).to eq("Ann's Helper")
    expect(user2.projects[0].name).to eq("John's Helper")
    expect(user2.projects[1].name).to eq("Ann's Helper")
    expect(user1.roles[0].name).to eq('Scrum Master')
    expect(user1.roles[1].name).to eq('Developer')
    expect(user2.roles[0].name).to eq('Developer')
    expect(user2.roles[1].name).to eq('Scrum Master')
  end
end
