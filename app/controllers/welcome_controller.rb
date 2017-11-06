class WelcomeController < ApplicationController
  def index
    if not (session[:token].nil? or session[:token].empty?)
      redirect_to projects_url
    end
  end
end
