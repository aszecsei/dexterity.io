class Workingon < ApplicationRecord
    belongs_to :project
    belongs_to :user
    belongs_to :role
    
    validates_presence_of :project_id
    validates_presence_of :role_id
    validates_presence_of :user_id
end
