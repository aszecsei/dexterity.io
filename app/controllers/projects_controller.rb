class ProjectsController < ApplicationController
  before_action :require_login, raise: false
  
  def index
    @title = "Projects"
    @projects = current_user.projects
  end
  
end
