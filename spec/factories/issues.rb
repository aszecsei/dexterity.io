require 'faker'

#       t.string :name, :null => false
#       t.string :description
#       t.references :status, foreign_key: true, :null => false
#       t.references :category, foreign_key: true, :null => false
#       t.references :project, foreign_key: true, :null => false
      
#       t.references :assigned_to, foreign_key: { to_table: :users }
#       t.references :created_by, foreign_key: { to_table: :users }, :null => false
      
#       t.references :blocked_by, foreign_key: { to_table: :issues }
      
#       t.string :estimated_time
#       t.integer :story_points

FactoryGirl.define do
  factory :issue do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status_id { Faker::Number.digit }
    category_id { Faker::Number.digit }
    project_id { Faker::Number.digit }
    
    assigned_to_id { Faker::Number.digit }
    created_by_id { Faker::Number.digit }
    
    blocked_by nil
    
    estimated_time nil
    story_points { Faker::Number.digit }
  end
end
