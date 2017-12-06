class Api::ProjectsController < Api::ApiController
  before_action :require_login, raise: false
  
  def project_params
    params.permit(:name, :description)
  end
  
  def create
    proj = Project.new(project_params)
    if proj.save
      proj.create_owner(current_user)
      render json: {:id => proj.id, :name => proj.name, :description => proj.description}
    else
      render_error(:unprocessable_entity, "Could not create project")
    end
  end
  
  #intake user email/name and project name
  def addUser
    id = params[:id] # retrieve project ID from URI route
    proj = Project.find(id)
    if proj.add_user(params[:username],params[:rolename])
      head :no_content
    else
      render_error(:unprocessable_entity, "Could not add user")
    end
  end
  
  #intake project name
  def edit
    id = params[:id] # retrieve project ID from URI route
    proj = Project.find(id)
    if proj.edit(params[:name], params[:description])
      #head :no_content
      render json: {:name => proj.name, :description => proj.description}
    else
      render_error(:unprocessable_entity, "Failed to edit project")
    end
  end
  
  #intake role and project name
  def addRole
    id = params[:id] # retrieve project ID from URI route
    proj = Project.find(id)
    if proj.add_role(params[:rolename])
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to add a role")
    end
  end
  
  #intake user email/name and role and project name
  def assignedRole
    id = params[:id] # retrieve project ID from URI route
    rolename = params[:rolename]
    proj = Project.find(id)
    role = Role.find_by(project_id: id)
    if proj.assigned_role(params[:username], rolename)
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to assign a role")
    end
  end
  
  def destroy
    id = params[:id]
    proj = Project.find(id)
    if proj.nil?
      render_error(:unprocessable_entity, "Project does not exist")
    else
      proj.destroy
      head :no_content
    end
  end
  
end