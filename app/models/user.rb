class User < ApplicationRecord
    has_secure_password
    has_secure_token
    
    has_many :workingons
    has_many :projects, :through => :workingons
    has_many :roles, :through => :workingons
    
    has_many :assignments
    has_many :assigned_issues, :through => :assignments
    
    has_many :created_issues, foreign_key: "created_by_id", class_name: "Issue"

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
    
    def self.sign_in_from_omniauth(auth)
        find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
    end
    
    def self.create_user_from_omniauth(auth)
        create(
            provider: auth['provider'],
            uid: auth['uid'],
            name: auth['info']['name']
        )
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
