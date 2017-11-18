class WelcomeController < ApplicationController
  def index
    if (authenticate_token)
      redirect_to projects_url
    end
  end
end
