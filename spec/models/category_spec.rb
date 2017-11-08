require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    proj = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:category, project: proj)).to be_valid
  end
  
  it "is invalid without a name" do
    proj = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:category, project: proj, name: nil)).to_not be_valid
  end
  
  it "is invalid without a project" do
    expect(FactoryGirl.build(:category, project: nil)).to_not be_valid
  end
end
