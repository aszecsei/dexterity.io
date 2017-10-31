class UsersController < ApplicationController
    def user_params
        params.require(:user).permit(:email, :password)
    end
  
    def new
    end
  
    def create
        if User.find_by_user_email(user_params[:email]) != nil
          flash[:warning] = "Sorry, this email is taken. Try again."
          redirect_to new_user_path
        else
          @user = User.create_user!(user_params)
          
          flash[:notice] = "Welcome #{@user.user_id}. Your account has been created"
          redirect_to login_path
        end
    end
end
