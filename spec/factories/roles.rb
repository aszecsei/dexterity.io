# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :role do |f|
    f.name { Faker::Name.name }
    f.project_id { Faker::Number.digit }
    f.add_issues { Faker::Boolean.boolean(0) }
    f.close_issues { Faker::Boolean.boolean(0) }
    f.assign_issues { Faker::Boolean.boolean(0) }
    f.edit_project { Faker::Boolean.boolean(0) }
    f.delete_project { Faker::Boolean.boolean(0) }
    f.add_project_members { Faker::Boolean.boolean(0) }
    f.remove_project_members { Faker::Boolean.boolean(0) }
  end
end
