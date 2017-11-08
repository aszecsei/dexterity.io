class Project < ApplicationRecord
    validates_presence_of :name
    has_many :roles
    has_many :workingons
    has_many :users, :through => :workingons
    has_many :statuses
    has_many :categories
    has_many :issues
    
    def create_owner(current_user)
        
        ownerRole = roles.create({:name => "owner",
            :add_issues => true,
            :close_issues => true,
            :assign_issues => true,
            :edit_project => true,
            :delete_project => true,
            :add_project_members => true,
            :remove_project_members => true
        })
        
        workingons.create({:user_id => current_user.id,
            :role_id => ownerRole.id
        })
    end
end
