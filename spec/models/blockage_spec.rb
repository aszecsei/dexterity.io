require 'rails_helper'

RSpec.describe Blockage, type: :model do
  before(:each) do
    @usr = FactoryGirl.create(:user)
    @proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: @proj)
    cat  = FactoryGirl.create(:category, project: @proj)
    @issue = FactoryGirl.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
    @issue2 = FactoryGirl.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
  end
  it "has a valid factory" do
    expect(FactoryGirl.build(:blockage, issue: @issue, blocked_issue: @issue2)).to be_valid
  end
   it "is invalid without an issue" do
    expect(FactoryGirl.build(:blockage, issue: nil, blocked_issue: @issue2)).to_not be_valid
  end
  it "is invalid without a blocked issue" do
    expect(FactoryGirl.build(:blockage, issue: @issue, blocked_issue: nil)).to_not be_valid
  end
end