require 'faker'

FactoryBot.define do
  factory :activitylog do
    activity_type "To Do"
    description { Faker::Lorem.sentence }
    user_id { Faker::Number.digit }
    issue_id { Faker::Number.digit }
  end
end
