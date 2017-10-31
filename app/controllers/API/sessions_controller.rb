class API::SessionsController < API::ApiController
    skip_before_action :require_login, only: [:create], raise: false

    def create
        if user = User.valid_login?(params[:email], params[:password])
            allow_token_to_be_used_only_once_for(user)
            send_auth_token_for_valid_login_of(user)
            flash[:notice] = "Login successfully"
            redirect_to root_url
        else
            render_unauthorized("Error with your login or password")
            flash[:warning] = "Invalid email or password"
            redirect_to login_url
        end
    end

    def destroy
        logout
        head :ok
        flash[:notice] = "Logout successfully"
    end

    private

    def send_auth_token_for_valid_login_of(user)
        render json: { token: user.token }
    end

    def allow_token_to_be_used_only_once_for(user)
        user.regenerate_token
    end

    def logout
        current_user.invalidate_token
    end
end