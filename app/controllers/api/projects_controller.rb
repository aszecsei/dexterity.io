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
      render_error(:unprocessable_entity, "Could not create project")
    end
  end
  
  #intake user email/name and role name
  def addUser
    #proj = Project.find_by(name: name)
    proj = current_proj
    if proj.add_user(params[:username],params[:rolename])
      head :no_content
    else
      render_error(:unprocessable_entity, "Could not add user")
    end
  end
  
  #intake project name
  def edit
    if edit_project(params[:projectOldName], params[:projectNewName], params[:projectdescription])
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to edit project")
    end
  end
  
  #intake role and project name
  def addRole
    if add_role(params[:rolename])
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to add a role")
    end
  end
  
  #intake user email/name and role and project name
  def assignedRole
    if assigned_role(params[:username], params[:rolename])
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to assign a role")
    end
  end
  
end