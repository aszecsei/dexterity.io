class Project < ApplicationRecord
    validates_presence_of :name
    has_many :roles
    has_many :workingons
    has_many :users, :through => :workingons
end
