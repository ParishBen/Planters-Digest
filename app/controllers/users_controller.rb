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
        redirect_if_not_logged_in
        @user = User.find(params[:id])
        not_current_user
    end

    def update
        redirect_if_not_logged_in
        @user = User.find(params[:id])
        not_current_user
        @user.update(user_params)
        if @user.save
            redirect_to user_path(@user)
        else 
            flash[:message]="Please fill out all fields"
            render :edit
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
            flash[:message]="Please fill out all fields"
            render :new
        end
    end

    def index
        redirect_if_not_logged_in
        @users = User.most_plants
    end

    def show
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])     
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end
end
