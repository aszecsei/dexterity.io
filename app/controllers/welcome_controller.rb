class WelcomeController < ApplicationController
  def index
    if not session[:token].empty?
      redirect_to projects_url
    end
  end
end
