class UsersController < ApplicationController
    include UsersHelper
    def welcome
        render :welcome
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        
    end

    private
    def user_params
        params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end
end
