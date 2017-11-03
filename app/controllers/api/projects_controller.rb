class Api::ProjectsController < Api::ApiController
  before_action :require_login, raise: false
  
  def project_params
    params.permit(:name, :description)
  end
  
  def create
    proj = Project.new(project_params)
    if proj.save
      proj.create_owner(current_user)
      render json: {:name => proj.name, :description => proj.description}
    else
      render_error("Could not create project", :unprocessable_entity)
    end
  end
  
end