require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Job.title }
    description { Faker::Lorem.sentence }
    project_id { Faker::Number.digit }
  end
end
