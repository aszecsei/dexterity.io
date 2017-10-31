class SessionsController < ApplicationController
    def new
    end
    
    def create
        if User.valid_token?(params[:token])
            # Save the user ID in the session so it can be used in
            # subsequent requests
            session[:token] = params[:token]
            #flash[:notice] = "Login successfully"
            redirect_to projects_url
        else
            flash[:error] = 'Access denied'
            redirect_to welcome_url
        end
    end
    
    def index
        redirect_to login_url
    end
end
