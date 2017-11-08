require 'rails_helper'

RSpec.describe Issue, type: :model do
  it "has a valid factory" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    cat  = FactoryGirl.create(:category, project: proj)
    expect(FactoryGirl.build(:issue, project: proj, status: stat, category: cat, created_by: usr)).to be_valid
  end
  
  it "is invalid without a name" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    cat  = FactoryGirl.create(:category, project: proj)
    expect(FactoryGirl.build(:issue, project: proj, status: stat, category: cat, created_by: usr, name: nil)).to_not be_valid
  end
  
  it "is invalid without a creator" do
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    cat  = FactoryGirl.create(:category, project: proj)
    expect(FactoryGirl.build(:issue, project: proj, status: stat, category: cat)).to_not be_valid
  end
  
  it "is invalid without a status" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    cat  = FactoryGirl.create(:category, project: proj)
    expect(FactoryGirl.build(:issue, project: proj, category: cat, created_by: usr, name: nil)).to_not be_valid
  end
  
  it "is invalid without a category" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    expect(FactoryGirl.build(:issue, project: proj, status: stat, created_by: usr, name: nil)).to_not be_valid
  end
end
