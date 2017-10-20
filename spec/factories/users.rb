# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
    factory :user do |f|
        f.username { Faker::Internet.user_name }
        f.email { Faker::Internet.email }
        f.displayName { Faker::Name.name }
        f.password { Faker::Internet.password(10, 20) }
    end
end