class Project < ApplicationRecord
    after_create :setup_defaults
    
    validates_presence_of :name
    has_many :roles
    has_many :workingons
    has_many :users, :through => :workingons
    has_many :statuses
    has_many :categories
    has_many :issues
    
    def ownerRole()
        roles.find_by_name("Owner")
    end
    
    def setup_defaults()
        # Set up default roles
        roles.create({
            :name => "Owner",
            :add_issues => true,
            :close_issues => true,
            :assign_issues => true,
            :edit_project => true,
            :delete_project => true,
            :add_project_members => true,
            :remove_project_members => true
        })
        roles.create({
            :name => "Developer",
            :add_issues => true,
            :close_issues => false,
            :assign_issues => true,
            :edit_project => false,
            :delete_project => false,
            :add_project_members => false,
            :remove_project_members => false
        })
        
        # Set up default statuses
        statuses.create({
            :name => "Open",
            :description => "This issue is not currently being worked on.",
            :category => "To Do"
        })
        
        statuses.create({
            :name => "In Progress",
            :description => "This issue is currently being worked on.",
            :category => "In Progress"
        })
        
        statuses.create({
            :name => "Closed",
            :description => "The developer who worked on the issue has declared it finished.",
            :category => "Done"
        })
        
        statuses.create({
            :name => "Resolved",
            :description => "The product owner has reviewed the issue and has declared it finished.",
            :category => "Done"
        })
        
        # Set up default categories
        categories.create({
            :name => "Story",
            :description => "A user story is the smallest unit of work that needs to be done."
        })
        
        categories.create({
            :name => "Bug",
            :description => "A bug is a problem which impairs or prevents the functions of a product."
        })
    end
    
    def create_owner(current_user)
        workingons.create({
            :user => current_user,
            :role => ownerRole
        })
    end
    
    def add_user(username, rolename)
        if user = find_by(username: username)
            role = add_role(rolename)
            workingons.create({
                :user => user,
                :role => role
            })
        end
    end
    
    def add_role(role_name)
        roles.create({
            :name => role_name
        })
    end
    
    def edit_project(projectOldName, projectNewName, projectdescription)
        if proj = find_by(name: projectOldName)
            proj.name = projectNewName
            proj.description = projectdescription
            proj.save
        end
    end
    
    def assigned_role(username, rolename)
        user = find_by(username: username) 
        role = find_by(name: rolename)
        if user && role
            workingons.create({
                :user => user,
                :role => role
            })
        end
    end
end
