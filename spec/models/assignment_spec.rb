require 'rails_helper'

RSpec.describe Assignment, type: :model do
  before(:each) do
    @usr = FactoryBot.create(:user)
    @proj = FactoryBot.create(:project)
    stat = FactoryBot.create(:status, project: @proj)
    cat  = FactoryBot.create(:category, project: @proj)
    @issue = FactoryBot.create(:issue, project: @proj, status: stat, category: cat, created_by: @usr)
  end
  it "has a valid factory" do
    expect(FactoryBot.build(:assignment, issue: @issue, user: @usr)).to be_valid
  end
   it "is invalid without a user" do
    expect(FactoryBot.build(:assignment, issue: @issue, user: nil)).to_not be_valid
  end
  it "is invalid without an issue" do
    expect(FactoryBot.build(:assignment, issue: nil, user: @usr)).to_not be_valid
  end
end
