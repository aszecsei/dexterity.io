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
  
  it "should be able to see the other issues of the statuses it belongs to" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    cat  = FactoryGirl.create(:category, project: proj)
    iss = FactoryGirl.create(:issue, project: proj, status: stat, created_by: usr, category: cat)
    iss2 = FactoryGirl.create(:issue, project: proj, status: stat, created_by: usr, category: cat)
    iss3 = FactoryGirl.create(:issue, project: proj, status: stat, created_by: usr, category: cat)
    iss.next_id = iss2.id
    iss2.next_id = iss3.id
    expect(iss2.previous.name).to eq(iss.name)
    expect(iss2.next.name).to eq(iss3.name)
    expect(iss3.next).to eq(nil)
  end
  
  it "shouldn't be able to see issues of statuses it doesn't belong to" do
    usr  = FactoryGirl.create(:user)
    proj = FactoryGirl.create(:project)
    stat = FactoryGirl.create(:status, project: proj)
    stat2 = FactoryGirl.create(:status, project: proj)
    cat  = FactoryGirl.create(:category, project: proj)
    iss = FactoryGirl.create(:issue, project: proj, status: stat, created_by: usr, category: cat)
    iss2 = FactoryGirl.create(:issue, project: proj, status: stat2, created_by: usr, category: cat)
    expect(iss.first?).to eq(true)
    expect(iss.next).to eq(nil)
  end
  
end
