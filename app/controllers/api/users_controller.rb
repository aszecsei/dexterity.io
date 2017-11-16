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
  
  def destroy
    @user = current_user
    if @user.destroy
      head :no_content
    else
      render_error(:unprocessable_entity, "Failed to delete account")
    end
  end
  
  def update
    @user = current_user
    if @user.update_attributes(user_params)
      head :no_content
    else 
      render_error(:unprocessable_entity, "Failed to update information")
    end
  end
  
  def change_password
    @user = current_user
    if @user.authenticate(params[:password])
      @user.update_attributes({:password => params[:password]})
      head :no_content
    else
      render_error(:unprocessable_entity, "Wrong Password!")
    end  
  end  
end