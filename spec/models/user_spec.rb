require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it "is invalid without a username" do
    expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
  end
  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end
  it "is invalid without a display name" do
    expect(FactoryGirl.build(:user, displayName: nil)).to_not be_valid
  end
  it "does not allow duplicate usernames" do
    FactoryGirl.create(:user, username: 'test')
    expect(FactoryGirl.build(:user, username: 'test')).to_not be_valid
  end
  it "does not allow duplicate emails" do
    FactoryGirl.create(:user, email: 'test@test.com')
    expect(FactoryGirl.build(:user, email: 'test@test.com')).to_not be_valid
  end
  
  it "invalidates tokens" do
    usr = FactoryGirl.create(:user, token: 'test')
    expect(usr.token).to eq('test')
    usr.invalidate_token
    usr.reload
    expect(usr.token).to eq(nil)
  end
  
  it "validates successful logins" do
    usr = FactoryGirl.create(:user)
    expect(User.valid_login?(usr.username, usr.password)).to be_truthy
  end
  
  it "validates unsuccessful logins" do
    expect(User.valid_login?("test", "test")).to_not be_truthy
  end
  
  it "validates successful tokens" do
    usr = FactoryGirl.create(:user, token: 'test')
    expect(User.valid_token?('test')).to be_truthy
  end
  
  it "invalidates unsuccessful tokens" do
    usr = FactoryGirl.create(:user, token: 'test')
    expect(User.valid_token?('')).to be_falsey
    expect(User.valid_token?(nil)).to be_falsey
    expect(User.valid_token?('other')).to be_falsey
  end
  
  it "connects to the correct project" do
    user1 = FactoryGirl.create(:user)
    FactoryGirl.create(:project, name: "John's Helper")
    FactoryGirl.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    expect(user1.projects[0].name).to eq("John's Helper")
  end
  
  it "connects to the correct role" do
    user1 = FactoryGirl.create(:user)
    FactoryGirl.create(:project, name: "John's Helper")
    FactoryGirl.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    expect(user1.roles[0].name).to eq('Scrum Master')
  end
  
  it "can connect to multiple projects and roles" do
    user1 = FactoryGirl.create(:user)
    FactoryGirl.create(:project, name: "John's Helper")
    FactoryGirl.create(:project, name: "Ann's Helper")
    FactoryGirl.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryGirl.create(:role, project_id: 2, name: 'Scrum Master')
    FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    FactoryGirl.create(:workingon, project_id: 2, user_id: 1, role_id: 2)
    expect(user1.projects.length).to eq(2)
    expect(user1.roles.length).to eq(2)
  end
  
  it "can properly distinguish projects and roles" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    FactoryGirl.create(:project, name: "John's Helper")
    FactoryGirl.create(:project, name: "Ann's Helper")
    FactoryGirl.create(:role, project_id: 1, name: 'Scrum Master')
    FactoryGirl.create(:role, project_id: 2, name: 'Developer')
    FactoryGirl.create(:role, project_id: 1, name: 'Developer')
    FactoryGirl.create(:role, project_id: 2, name: 'Scrum Master')
    FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)
    FactoryGirl.create(:workingon, project_id: 1, user_id: 2, role_id: 3)
    FactoryGirl.create(:workingon, project_id: 2, user_id: 1, role_id: 2)
    FactoryGirl.create(:workingon, project_id: 2, user_id: 2, role_id: 4)
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
