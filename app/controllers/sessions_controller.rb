class SessionsController < ApplicationController
    def new
    end
    
    def create
        if User.valid_token?(params[:token])
            # Save the user ID in the session so it can be used in
            # subsequent requests
            session[:token] = params[:token]
            #flash[:notice] = "Login successfully"
            redirect_to root_url
        else
            flash[:error] = 'Access denied'
            redirect_to login_url
        end
    end
    
    def ocreate
        auth = request.env["omniauth.auth"]         # response from callback
        session[:omniauth] = auth.except('extra')
        user= User.sign_in_from_omniauth(auth)
        session[:user_id] = user.id
        redirect_to root_url
    end
    
    def destroy
        session[:amniauth] = nil
        session[:user_id] = nil
        redirect_to root_url
    end
end
