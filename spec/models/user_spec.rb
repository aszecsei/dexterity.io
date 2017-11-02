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
end
