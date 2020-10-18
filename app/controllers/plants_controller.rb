class PlantsController < ApplicationController
    def show
        @conditions = ["It Died", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet!"]
        if params[:user_id]
            @plant = Plant.find_by(id: params[:id])
            @user = User.find_by(id: params[:user_id]) 
            @plant.logs.build   
        elsif
             @plant = Plant.find_by(id: params[:id])
             #@plant.comments.build
        else
           
            flash[:notice] = "Sorry, That is not a Plant"
            redirect_to plants_path
        end
    end
    
    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            @plants = User.find_by(id: params[:user_id]).plants
        else
        @plants = Plant.all
       end
       
    end

    def edit
        @plant = Plant.find_by(id: params[:id])
        #redirect_to plant_path(@plant) if @plant.user != current_user
    end

    def update
        @plant = Plant.find(params[:id])
        @plant.update(plant_params)
        if @plant.save
            redirect_to plant_path(@plant)
        else
            render :edit
        end
        
    end

    def new
        @plant = Plant.new
    end

    def create
        @plant = Plant.new(plant_params)
        if @plant.save
          redirect_to plant_path(@plant)
        else
          render :new
        end
    end
    
    private
    def plant_params
        params.require(:plant).permit(:nickname, :plant_type, :user_id, comments_attributes:[:content, :plant_id, :commenter_id], logs_attributes:[:notes, :water_date, :plant_id])
        
    end
end
