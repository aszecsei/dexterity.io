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
    
    def ocreate
        auth = request.env["omniauth.auth"]         # response from callback
        session[:omniauth] = auth.except('extra')
        user= User.sign_in_from_omniauth(auth)
        session[:user_id] = user.id
        user.regenerate_token
        #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
        render json: {:token => user.token}
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