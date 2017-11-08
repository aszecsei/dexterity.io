class Api::IssuesController < Api::ApiController
  before_action :require_login, raise: false
  
  def issue_params
    params.permit(:name, :description)
  end
  
  def create
    issue = Issue.new(issue_params)
    if issue.save
      render json: {:name => issue.name, :description => issue.description}
    else
      render_error(:unprocessable_entity, "Could not create issue")
    end
  end
end