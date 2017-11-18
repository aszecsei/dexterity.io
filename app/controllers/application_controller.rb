class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def require_login
      current_user
      authenticate_token || handle_unauthorized
  end

  def current_user
      @current_user ||= authenticate_token
  end
  
  def handle_unauthorized
    flash[:error] = 'Access denied'
    redirect_to login_url
  end
    
  private
  
  def authenticate_token
    User.valid_token?(session[:token])
  end
end
