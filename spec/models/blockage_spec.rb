require 'rails_helper'

RSpec.describe Blockage, type: :model do
  before(:each) do
    @usr = FactoryBot.create(:user)
    @proj = FactoryBot.create(:project)
    stat = FactoryBot.create(:status, project: @proj)
    cat  = FactoryBot.create(:category, project: @proj)
    @issue = FactoryBot.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
    @issue2 = FactoryBot.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
  end
  it "has a valid factory" do
    expect(FactoryBot.build(:blockage, issue: @issue, blocked_issue: @issue2)).to be_valid
  end
   it "is invalid without an issue" do
    expect(FactoryBot.build(:blockage, issue: nil, blocked_issue: @issue2)).to_not be_valid
  end
  it "is invalid without a blocked issue" do
    expect(FactoryBot.build(:blockage, issue: @issue, blocked_issue: nil)).to_not be_valid
  end
end
