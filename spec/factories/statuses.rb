require 'faker'

FactoryGirl.define do
  factory :status do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    category "To Do"
    project_id { Faker::Number.digit }
  end
end
