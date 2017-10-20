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
end
