require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end
  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid without a display name" do
    FactoryGirl.build(:user, displayName: nil).should_not be_valid
  end
  it "does not allow duplicate usernames" do
    FactoryGirl.create(:user, username: 'test')
    FactoryGirl.build(:user, username: 'test').should_not be_valid
  end
  it "does not allow duplicate emails" do
    FactoryGirl.create(:user, email: 'test@test.com')
    FactoryGirl.build(:user, email: 'test@test.com').should_not be_valid
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
end
