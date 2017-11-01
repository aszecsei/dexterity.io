require 'rails_helper'
require 'spec_helper'

RSpec.describe Role, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:role).should be_valid
  end
end
