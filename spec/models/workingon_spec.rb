require 'rails_helper'
require 'spec_helper'

RSpec.describe Workingon, type: :model do
  before(:each) do
    FactoryGirl.create(:user, username: 'John Doe')
    FactoryGirl.create(:project, name: "John's Helper")
    FactoryGirl.create(:role, project_id: 1)
  end
  it "has a valid factory" do
    expect(FactoryGirl.create(:workingon, project_id: 1, user_id: 1, role_id: 1)).to be_valid
  end
   it "is invalid without a user" do
    expect(FactoryGirl.build(:workingon, user_id: nil)).to_not be_valid
  end
  it "is invalid without a role" do
    expect(FactoryGirl.build(:workingon, role_id: nil)).to_not be_valid
  end
  it "is invalid without a project" do
    expect(FactoryGirl.build(:workingon, project_id: nil)).to_not be_valid
  end
end
