# spec/factories/projects.rb
require 'faker'

FactoryGirl.define do
  factory :project do |f|
    f.name{Faker::Name.name}
  end
end
