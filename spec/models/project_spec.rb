require 'rails_helper'
require 'spec_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end
  it "is invalid without a name" do
    expect(FactoryGirl.build(:project, name: nil)).to_not be_valid
  end
  it "has access to multiple roles" do
    @project1 = FactoryGirl.create(:project)
    FactoryGirl.create(:role, name: 'Scrum Master', project_id: 1)
    FactoryGirl.create(:role, name: 'Project Owner', project_id: 1)
    expect(@project1.roles[0].name).to eq('Scrum Master')
    expect(@project1.roles[1].name).to eq('Project Owner')
  end
end
