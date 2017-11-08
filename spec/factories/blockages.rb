FactoryGirl.define do
  factory :blockage do
    issue_id { Faker::Number.digit }
    blocked_issue_id { Faker::Number.digit }
  end
end
