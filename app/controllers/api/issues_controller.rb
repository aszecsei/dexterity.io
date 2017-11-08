class Api::IssuesController < Api::ApiController
  before_action :require_login, raise: false
  
  def issue_params
    params[:estimated_time] = ChronicDuration.parse(params[:estimated_time])
    params.permit(:name, :description, :project_id, :estimated_time, :status_id, :category_id, :story_points).merge(created_by_id: current_user.id)
  end
  
  def create
    issue = Issue.new(issue_params)
    if issue.save
      render json: {
        :id => issue.id,
        :name => issue.name,
        :description => issue.description,
        :project_id => issue.project_id,
        :status_id => issue.status_id,
        :category_id => issue.category_id,
        :estimated_time => issue.estimated_time_string,
        :story_points => issue.story_points
      }
    else
      render_error(:unprocessable_entity, issue.errors)
    end
  end
end