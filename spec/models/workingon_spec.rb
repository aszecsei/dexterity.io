require 'rails_helper'
require 'spec_helper'

RSpec.describe Workingon, type: :model do
  before(:each) do
    FactoryBot.create(:user, username: 'John Doe')
    FactoryBot.create(:project, name: "John's Helper")
    FactoryBot.create(:role, project_id: 1)
  end
  it "has a valid factory" do
    expect(FactoryBot.create(:workingon, project_id: 1, user_id: 1, role_id: 1)).to be_valid
  end
   it "is invalid without a user" do
    expect(FactoryBot.build(:workingon, user_id: nil)).to_not be_valid
  end
  it "is invalid without a role" do
    expect(FactoryBot.build(:workingon, role_id: nil)).to_not be_valid
  end
  it "is invalid without a project" do
    expect(FactoryBot.build(:workingon, project_id: nil)).to_not be_valid
  end
end
