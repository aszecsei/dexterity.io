class WelcomeController < ApplicationController
  before_action :set_auth
  
  def index
    if (authenticate_token)
      redirect_to projects_url
    end
  end
  
  private
  
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
