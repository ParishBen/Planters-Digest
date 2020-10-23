class UsersController < ApplicationController
    include UsersHelper
    def welcome
        if !logged_in?
           render :welcome
        else 
            redirect_to user_path(current_user)
        end
    end
    
    def edit
        @user = User.find(params[:id])
        if @user != current_user
            redirect_to user_path(@user)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user != current_user
            redirect_to user_path(@user)
        elsif @user.update(user_params)
        if @user.save
            redirect_to user_path(@user)
        else 
            render :edit
        end
      end
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
