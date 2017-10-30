class Project < ApplicationRecord
    validates_presence_of :name
    has_many :roles
end
