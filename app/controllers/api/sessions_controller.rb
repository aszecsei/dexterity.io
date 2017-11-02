class Api::SessionsController < Api::ApiController
    skip_before_action :require_login, only: [:create], raise: false

    def create
        if User.valid_login?(params[:username], params[:password])
            user = User.find_by_username(params[:username])
            user.regenerate_token
            render json: {:token => user.token}
        else
            render_unauthorized("Invalid username or password")
        end
    end

    def destroy
        if current_user.nil?
           render_unauthorized("No user is currently logged in.") 
        else
            current_user.invalidate_token
            head :no_content
        end
    end
end