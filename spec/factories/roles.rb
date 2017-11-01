# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :role do |f|
    f.name { Faker::Name.name }
    f.project_id { Faker::Number.digit }
    f.add_issues { Faker::Number.binary }
    f.close_issues { Faker::Number.binary }
    f.assign_issues { Faker::Number.binary }
    f.edit_project { Faker::Number.binary }
    f.delete_project { Faker::Number.binary }
    f.add_project_members { Faker::Number.binary }
    f.remove_project_members { Faker::Number.binary }
  end
end
