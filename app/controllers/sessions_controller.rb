class SessionsController < ApplicationController
    include UsersHelper
    def new
       if !logged_in? 
          render :new
       else
          redirect_to user_path(current_user)
       end
    end

    def google
       @user = User.find_or_create_by(email: auth["info"]["email"])
        @user.username = auth["info"]["email"]
        @user.name = auth["info"]["first_name"] +" "+ auth["info"]["last_name"]
        @user.password = SecureRandom.hex(10)
    
        if @user.save
           session[:user_id]= @user.id
           redirect_to user_path(@user)     
        else
           redirect_to welcome_path
        end
    end


    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            flash[:message] = "Sorry we couldn't verify that info. Please try again."
            redirect_to login_path
        end
    end

    def destroy
        redirect_if_not_logged_in
        reset_session
        redirect_to welcome_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end
    
end
