# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :role do |f|
    f.name { Faker::Name.name }
    f.project_id { Faker::Number.digit }
    f.add_issues { Faker::Boolean.boolean }
    f.close_issues { Faker::Boolean.boolean }
    f.assign_issues { Faker::Boolean.boolean }
    f.edit_project { Faker::Boolean.boolean }
    f.delete_project { Faker::Boolean.boolean }
    f.add_project_members { Faker::Boolean.boolean }
    f.remove_project_members { Faker::Boolean.boolean }
  end
end
