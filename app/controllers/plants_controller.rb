class PlantsController < ApplicationController
    include UsersHelper
    
    def show
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        @log = Log.new
        @comment = Comment.new
        @comment.commenter_id = current_user.id
        if !params[:user_id]
            @plant = Plant.find_by(id: params[:id])
            @user = @plant.user
            render :show
        elsif params[:user_id]
            @user = User.find_by(id: params[:user_id]) 
            @plant = Plant.find_by(id: params[:id]) 
        if !@user.plants.include?(@plant)
            flash[:message] = "Sorry, that plant doesn't belong to that User"
            redirect_to user_path(@user)
        elsif @user.plants.include?(@plant)
            render :show
        else
            flash[:notice] = "Sorry, That is not a Plant"
            redirect_to plants_path
            end
         end
      end
    
     
   
    
    def index
        #if params[:user_id]
           if @user = User.find_by(id: params[:user_id])
            @plants = User.find_by(id: params[:user_id]).plants
           else
        @plants = Plant.all
       end
       
    end

    def edit
        @plant = Plant.find_by(id: params[:id])
        if @plant.user != current_user
            flash[:message] = "You aren't permitted to edit this plant"
            redirect_to plant_path(@plant) if @plant.user != current_user
        end
    end
            
    def update
        @plant = Plant.find(params[:id])        
        @plant.update(plant_params)
          if @plant.save
            redirect_to plant_path(@plant)
          elsif params[:plant][:comments_attributes] && params[:plant][:comments_attributes][:"0"][:content].blank?
                flash[:message] = "Comment field must be filled out"
                redirect_to plant_path(@plant)
          elsif params[:plant][:logs_attributes] && params[:plant][:logs_attributes][:"0"][:water_date].blank?
                    flash[:message] = "Logs must have Water Date & Condition Update."
                    redirect_to plant_path(@plant)
          
        else 
            flash[:message]= "Comment's field cannot be empty."
            redirect_to plant_path(@plant) 
        #end
    #end
       end
     end

    def new
        @plant = Plant.new
        #@plant.user_id = current_user.id
        
    end

    def create
        @plant = Plant.new(plant_params)
        @plant.user_id = current_user.id
        if @plant.save
          redirect_to plant_path(@plant)
        else
          render :new
        end
    end

        def destroy
            @plant = Plant.find(params[:id])
              if current_user.plants.include?(@plant)
                 @plant.destroy
                 redirect_to user_path(current_user) 
              else
                 flash[:message]= "You are not authorized to destroy that Plant."
                 redirect_to user_path(current_user)
              end
        end
    
    private
    def plant_params
        params.require(:plant).permit(:id, :nickname, :plant_type, :user_id, comments_attributes:[:content, :plant_id, :commenter_id], logs_attributes:[:condition_update, :notes, :water_date, :plant_id])
        
    end
end
