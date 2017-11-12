class SwimlanesController < ApplicationController
    before_action :require_login, raise: false
    
    def index
        id = params[:id] # retrieve project ID from URI route
        
        @project = Project.find(id) # look up project by unique ID
        @title = @project.name
        @categories = @project.categories
        #@swimlanes = @project.swimlanes
        @user = @project.users
        @status = @project.statuses

    end
end
