require 'faker'

FactoryBot.define do
  factory :workingon do |f|
    f.project_id { Faker::Number.digit }
    f.user_id { Faker::Number.digit }
    f.role_id { Faker::Number.digit }
  end
end
