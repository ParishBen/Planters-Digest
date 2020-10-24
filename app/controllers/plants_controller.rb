class PlantsController < ApplicationController
    include UsersHelper
    
    def show
      redirect_if_not_logged_in
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        @log = Log.new
        @comment = Comment.new
        @comment.commenter_id = current_user.id
          if !params[:user_id]
            @plant = Plant.find_by(id: params[:id])
          elsif params[:user_id]
            @user = User.find_by(id: params[:user_id]) 
            @plant = Plant.find_by(id: params[:id])
          if params[:user_id] && @user.plants.include?(@plant)
            render :show
          else
          if params[:user_id] ? flash[:message] = "Sorry, That Plant doesn't belong to #{User.find(params[:user_id]).username}" : flash[:message]= "Sorry that isn't a Plant."
             redirect_to plants_path
          end
        end
      end
    end


    def index
        redirect_if_not_logged_in
        if @user = User.find_by(id: params[:user_id])
          @plants = @user.plants.popular
        else
          @plants = Plant.popular
       end   
    end

    def edit
      redirect_if_not_logged_in
      @plant = Plant.find_by(id: params[:id])
      @user = @plant.user
      not_current_user
    end
            
    def update
      redirect_if_not_logged_in
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
       end
     end

    def new
      redirect_if_not_logged_in
        @plant = Plant.new        
    end

    def create
      redirect_if_not_logged_in
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
          redirect_if_not_logged_in
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
        params.require(:plant).permit(:id, :nickname, :plant_type, :user_id, comments_attributes:[:content, :plant_id, :commenter_id], logs_attributes:[:condition_update, :notes, :water_date, :plant_id])   
    end
end
