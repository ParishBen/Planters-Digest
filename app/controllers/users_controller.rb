class UsersController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:edit, :update, :show, :index, :destroy]
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
        not_current_user
    end

    def update
        @user = User.find(params[:id])
        not_current_user
          if @user.update(user_params)
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
        @users = User.most_plants
    end

    def show
        @user = User.find_by(id: params[:id])     
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end
end
