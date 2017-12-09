require 'rails_helper'

RSpec.describe Activitylog, type: :model do
  before(:each) do
    @usr = FactoryBot.create(:user)
    @proj = FactoryBot.create(:project)
    @proj.create_owner(@usr)
    @stat = FactoryBot.create(:status, project: @proj)
    @cat  = FactoryBot.create(:category, project: @proj)
    @issue = FactoryBot.build(:issue, project: @proj, status: @stat, category: @cat, created_by: @usr)
  end
  
  it 'has a valid factory' do
    expect(FactoryBot.create(:activitylog, issue: @issue, user: @usr)).to be_valid
  end
  
  it 'knows if its a to-do issue' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "To Do")
    expect(log.isIssueOpen).to be_truthy
  end
  it 'knows if its not a to-do issue' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "In Progress")
    expect(log.isIssueOpen).to be_falsy
  end
  
  it 'knows if its in progress' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "In Progress")
    expect(log.isIssueStartWork).to be_truthy
  end
  it 'knows if its not progress' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "To Do")
    expect(log.isIssueStartWork).to be_falsy
  end
  
  it 'knows if its done' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "Done")
    expect(log.isIssueClose).to be_truthy
  end
  it 'knows if its not done' do
    log = FactoryBot.create(:activitylog, issue: @issue, user: @usr, activity_type: "To Do")
    expect(log.isIssueClose).to be_falsy
  end
end
