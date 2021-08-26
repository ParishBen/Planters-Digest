class PlantsController < ApplicationController
    include UsersHelper
    before_action :redirect_if_not_logged_in, :set_plant, only: [ :show, :edit, :create, :update]
    
    def show
      @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
      if !@plant
        flash[:message] = "SORRY, NOT A PLANT!"
        redirect_to plants_path
      elsif @plant
        @log = @plant.logs.build
        @comment = @plant.comments.build
        @comment.commenter_id = current_user.id
          if !params[:user_id]
             set_plant
          elsif params[:user_id]
            @user = User.find_by(id: params[:user_id]) 
            set_plant
          if params[:user_id] && @user.plants.include?(@plant)
            render :show
          else
          if params[:user_id] ? flash[:message] = "Sorry, That Plant doesn't belong to #{User.find(params[:user_id]).username}" : flash[:message]= "Sorry that isn't a Plant."
             redirect_to plants_path
          end
        end
      end
     end
    end

    def index
      @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        if @user = User.find_by(id: params[:user_id])
          @plants = @user.plants.popular
        elsif params[:search]
          @plants = Plant.search(params[:search]).popular
        elsif @plants
          @log = @plants.find(plant.id).logs.build
          @comment = @plants.find(plant.id).comments.build
          @comment.commenter_id = current_user.id
        else 
          @plants = Plant.popular
       end   
    end

    def edit
      @user = @plant.user
      not_current_user
    end
            
    def update
      if @plant.update(plant_params)
          redirect_to plant_path(@plant)
      else 
          flash[:message]= "Comment's field cannot be empty."
          redirect_to plant_path(@plant) 
       end
     end

    def new
        @plant = Plant.new        
    end

    def create
        @plant = Plant.new(plant_params)
        @plant.user_id = current_user.id
        if @plant.save
          redirect_to plant_path(@plant)
        else
          flash[:message]= "Fill out all fields please."
          render :new
        end
    end

        def destroy
            @plant = Plant.find(params[:id])
            plant_not_current_users
            if @plant.destroy
               redirect_to user_path(current_user) 
            else
                flash[:message]= "You are not authorized to destroy that Plant."
                redirect_to user_path(current_user)
              end
         end
    
    private
    def plant_params
        params.require(:plant).permit( :search, :nickname, :plant_type, :user_id)   
    end
    def set_plant
      @plant = Plant.find_by(id: params[:id])
    end
 
end
