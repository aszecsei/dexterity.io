class Api::IssuesController < Api::ApiController
  before_action :require_login, raise: false
  
  def issue_params
    params[:estimated_time] = ChronicDuration.parse(params[:estimated_time])
    params.permit(:name, :description, :project_id, :estimated_time, :status_id, :category_id, :story_points).merge(created_by_id: current_user.id)
  end
  
  def create
    issue = Issue.new(issue_params)
    if issue.save
      if(issue.first? == false)
        issue2 = issue.previous
        issue2.next_id = issue.id
      end
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
  
  def update
     #finds the issue to be moved
     issue1 = Issue.find_by_id(params[:issue_id])
     if not issue1
       render_error(:unprocessable_entity, "Could not find issue")
       return
     end
     if(params[:status_id] == issue1.status_id)
      #finds the issue that first one will live after
      issue2 = Issue.find_by_id(params[:prev_id])
      if not issue2
        issue1.prepend
        head :no_content
      else
        issue1.append_to(issue2)
        head :no_content
      end
     else
      issue1.status_id = params[:status_id]
      #finds the issue that first one will live after
      issue2 = Issue.find_by_id(params[:prev_id])
      if not issue2
        issue1.prepend
        head :no_content
      else
        issue1.append_to(issue2)
        head :no_content
      end
    end
  end
end