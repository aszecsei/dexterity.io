require 'rails_helper'

RSpec.describe Assignment, type: :model do
  before(:each) do
    @usr = FactoryGirl.create(:user)
    @proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: @proj)
    cat  = FactoryGirl.create(:category, project: @proj)
    @issue = FactoryGirl.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
  end
  it "has a valid factory" do
    expect(FactoryGirl.build(:assignment, issue: @issue, user: @usr)).to be_valid
  end
   it "is invalid without a user" do
    expect(FactoryGirl.build(:assignment, issue: @issue, user: nil)).to_not be_valid
  end
  it "is invalid without an issue" do
    expect(FactoryGirl.build(:assignment, issue: nil, user: @usr)).to_not be_valid
  end
end
