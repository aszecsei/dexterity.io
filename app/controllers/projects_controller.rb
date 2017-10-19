class ProjectsController < ApplicationController
  def index
  end
  
  def show
    @id = params[:id] # retrieve project ID from URI route
    # @project = Project.find(id) # look up project by unique ID
  end
end
