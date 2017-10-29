require 'rails_helper'
require 'spec_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:project).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:project, name: nil).should_not be_valid
  end
end
