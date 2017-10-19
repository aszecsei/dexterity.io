class ProjectsController < ApplicationController
  def index
    @title = "Projects"
  end
  
  def show
    id = params[:id] # retrieve project ID from URI route
    @title = "Project #{id}"
    # @project = Project.find(id) # look up project by unique ID
  end
end
