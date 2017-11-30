class BurndownController < ApplicationController
  before_action :require_login, raise: false
  
  def index
    id = params[:id] # retrieve project ID from URI route
    @project = Project.find(id) # look up project by unique ID
    
    startDate = @project.created_at.to_date
    dateArray = startDate..Date.today
    
    # Get total issues
    data = dateArray.map{ |date|
      {
        :date => date.strftime("%b %d"),
        :amt  => @project.issues.select { |i| i.created_at <= date }.count
      }
    }
    @dates = "[" + data.map{|d| d[:date]}.inject(""){|sum,n| sum + "'" + n + "'" + ","} + "]"
    @data = "[" + data.map{|d| d[:amt]}.inject(""){|sum,n| sum + n.to_s + ","} + "]"
  end
end
