class Api::UsersController < Api::ApiController
  skip_before_action :require_login, only: [:create], raise: false
  def user_params
    params.permit(:username, :email, :password, :displayName)
  end
  
  def create

    user_params[:displayName] =user_params[:username]
    p user_params
    
    p usr = User.new(user_params)
    if usr.save
      usr.regenerate_token
      render json: {:token => usr.token}
    else
      render json: usr.errors, status: :unprocessable_entity
    end
  end
end