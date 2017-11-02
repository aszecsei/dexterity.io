class Role < ApplicationRecord
    belongs_to :project
    
    validates_presence_of :name
    validates_presence_of :project_id
    
    has_many :workingons
    has_many :users, :through => :workingons
end
