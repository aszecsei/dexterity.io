class ProjectsController < ApplicationController
  before_action :require_login, raise: false
  
  def index
    @title = "Projects"
  end
  
  def show
    id = params[:id] # retrieve project ID from URI route
    @title = "Project #{id}"
    # @project = Project.find(id) # look up project by unique ID
  end
end
