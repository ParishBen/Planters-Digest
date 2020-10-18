class SessionsController < ApplicationController
    include UsersHelper
    def new
       if !current_user 
          render :new
       else
          redirect_to user_path(current_user)
       end
    end

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            redirect_to login_path
        end
    end

    def destroy
        reset_session
        redirect_to welcome_path
    end
end