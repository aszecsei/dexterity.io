require 'faker'

FactoryGirl.define do
  factory :assignment do
    user_id { Faker::Number.digit }
    issue_id { Faker::Number.digit }
  end
end
