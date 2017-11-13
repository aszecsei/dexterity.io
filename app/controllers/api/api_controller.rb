class Api::ApiController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    
    def require_login
        authenticate_token || render_unauthorized("Access denied")
    end

    def current_user
        @current_user ||= authenticate_token
    end
    
    def current_proj
        @current_proj ||= authenticate_proj
    end

    protected

    def render_unauthorized(message)
        render_error(:unauthorized, message)
    end
    
    def render_error(status, message)
        errors = { errors: [ { detail: message } ] }
        render json: errors, status: status
    end

    private

    def authenticate_token
        authenticate_with_http_token do |token, options|
            # Compare the tokens in a time-constant manner, to mitigate timing attacks
            User.find_by(token: token)
        end
    end
    
    def authenticate_proj
        authenticate_with_http_proj do |name, options|
            Project.find_by(name: name)
        end
    end
end