require 'faker'

FactoryBot.define do
  factory :issue do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status_id { Faker::Number.digit }
    category_id { Faker::Number.digit }
    project_id { Faker::Number.digit }
    
    created_by_id { Faker::Number.digit }
    
    estimated_time nil
    story_points { Faker::Number.digit }
  end
end
