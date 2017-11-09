class SwimlanesController < ApplicationController
    before_action :require_login, raise: false
    
    def index
        id = params[:id] # retrieve project ID from URI route
        @title = "Project #{id}"
        @project = Project.find(id) # look up project by unique ID
        @categories = @project.categories
        #@swimlanes = @project.swimlanes
        @user = @project.users

    end
end
