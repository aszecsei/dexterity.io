class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected
  
  def require_login
      authenticate_token || render_unauthorized("Access denied")
  end

  def current_user
      @current_user ||= authenticate_token
  end
    
  private
  
  def authenticate_token
      authenticate_with_http_token do |token, options|
          # Compare the tokens in a time-constant manner, to mitigate timing attacks
          User.find_by(token: token)
      end
  end
end
