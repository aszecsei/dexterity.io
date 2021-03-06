require 'rails_helper'

RSpec.describe Status, type: :model do
  it "has a valid factory" do
    proj = FactoryBot.create(:project)
    expect(FactoryBot.build(:status, project: proj)).to be_valid
  end
  
  it "is invalid without a name" do
    proj = FactoryBot.create(:project)
    expect(FactoryBot.build(:status, project: proj, name: nil)).to_not be_valid
  end
  
  it "is invalid without a category" do
    proj = FactoryBot.create(:project)
    expect(FactoryBot.build(:status, project: proj, category: nil)).to_not be_valid
  end
  
  it "is invalid without a project" do
    expect(FactoryBot.build(:status, project: nil)).to_not be_valid
  end
  
  it "should be able to access issues" do
    proj = FactoryBot.create(:project)
    user = FactoryBot.create(:user)
    cat = FactoryBot.create(:category, :project => proj)
    stat = FactoryBot.create(:status, :project =>proj)
    iss = FactoryBot.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    iss2 = FactoryBot.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    expect(stat.issues).to include(iss)
    expect(stat.issues).to include(iss2)
  end
  
  it "should not be able to access issues of other statuses" do
    proj = FactoryBot.create(:project)
    user = FactoryBot.create(:user)
    cat = FactoryBot.create(:category, :project => proj)
    stat = FactoryBot.create(:status, :project =>proj)
    stat2 = FactoryBot.create(:status, :project => proj)
    iss = FactoryBot.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    iss2 = FactoryBot.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    iss3 = FactoryBot.create(:issue, status: stat2, project: proj, category: cat, created_by: user)
    expect(stat.issues).to include(iss)
    expect(stat.issues).to include(iss2)
    expect(stat.issues).to_not include(iss3)
    expect(stat2.issues).to_not include(iss)
    expect(stat2.issues).to_not include(iss2)
    expect(stat2.issues).to include(iss3)
  end
  
  it "should be able to see the other statuses of the project it belongs to" do
    proj = FactoryBot.create(:project)
    stat = FactoryBot.create(:status, :project =>proj, name: "1")
    stat2 = FactoryBot.create(:status, :project => proj, name: "2")
    stat3 = FactoryBot.create(:status, :project => proj, name: "3")
    stat.next_id = stat2.id
    stat2.next_id = stat3.id
    expect(stat2.previous.name).to eq(stat.name)
    expect(stat2.next.name).to eq(stat3.name)
    expect(stat3.next).to eq(nil)
  end
  
  it "shouldn't be able to see statuses of projects it doesn't belong to" do
    proj = FactoryBot.create(:project)
    proj2 = FactoryBot.create(:project)
    stat = FactoryBot.create(:status, :project =>proj)
    stat2 = FactoryBot.create(:status, :project => proj2)
    expect(stat.next).to eq(nil)
  end
  
  it "shouldn't be able to access issues of same statuses but different projects" do
    proj = FactoryBot.create(:project)
    proj2 = FactoryBot.create(:project)
    user = FactoryBot.create(:user)
    cat = FactoryBot.create(:category, :project => proj)
    stat = FactoryBot.create(:status, :project =>proj, name: "To do")
    stat2 = FactoryBot.create(:status, :project => proj2, name: "To do")
    iss = FactoryBot.create(:issue, status: stat, project: proj, category: cat, created_by: user)
    iss2 = FactoryBot.create(:issue, status: stat2, project: proj2, category: cat, created_by: user)
    expect(stat.issues).to include(iss)
    expect(stat.issues).to_not include(iss2)
    expect(stat2.issues).to_not include(iss)
    expect(stat2.issues).to include(iss2)
  end
end
