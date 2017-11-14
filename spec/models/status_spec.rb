require 'rails_helper'

RSpec.describe Status, type: :model do
  it "has a valid factory" do
    proj = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:status, project: proj)).to be_valid
  end
  
  it "is invalid without a name" do
    proj = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:status, project: proj, name: nil)).to_not be_valid
  end
  
  it "is invalid without a category" do
    proj = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:status, project: proj, category: nil)).to_not be_valid
  end
  
  it "is invalid without a project" do
    expect(FactoryGirl.build(:status, project: nil)).to_not be_valid
  end
  
  it "should be able to accsess issues" do
    proj = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    cat = FactoryGirl.create(:category, :project => proj)
    stat = FactoryGirl.create(:status, :project =>proj)
    iss = FactoryGirl.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    expect(stat.issues).to include(iss)
  end
end
