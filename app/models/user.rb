class User < ApplicationRecord
    has_secure_password
    has_secure_token
    
    has_many :workingons
    has_many :projects, :through => :workingons
    has_many :roles, :through => :workingons
    
    has_many :assigned_issues, foreign_key: "assigned_to", class_name: "Issue"
    has_many :created_issues, foreign_key: "created_by", class_name: "Issue"

    # This method is not available in has_secure_token
    def invalidate_token
        self.update_columns(token: nil)
    end

    def self.valid_login?(username, password)
        user = find_by(username: username)
        if user && user.authenticate(password)
            user
        end
    end
    
    validates_presence_of :username
    validates_presence_of :email
    validates_presence_of :displayName
    
    validates :username, uniqueness: true
    validates :email, uniqueness: true
    
    def self.valid_token?(token)
        if token.nil? or token.empty?
            return false
        end
        user = find_by(token: token)
        if user
            user
        end
    end
end
