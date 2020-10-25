class LogsController < ApplicationController
    include UsersHelper
    def new
        redirect_if_not_logged_in
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        if params[:plant_id]
            @log = Plant.find_by(id: params[:plant_id]).logs.build
        else
            @log = Log.new
            @log.plant_id = params[:plant_id] if params[:plant_id]
        end
    end

    def create
        redirect_if_not_logged_in
        @log = Log.new(log_params)
        @plant = Plant.find_by(id: @log.plant_id)
        if @log.save
        redirect_to plant_path(@plant)
        else
            flash[:message]= "Ensure All Fields are filled out."
            @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
            render :new 
        end
    end
    
    def show
        redirect_if_not_logged_in
        @log = Log.find(params[:id])
        @plant = Plant.find_by(id: @log.plant_id)
        flash[:message]= "Directed To Log's Plant Page"
        redirect_to plant_path(@plant)
    end
   
    
    def edit
        redirect_if_not_logged_in
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        @log = Log.find_by(id: params[:id])
        @plant = Plant.find_by(id: @log.plant_id)        
        plant_not_current_users
    end

    def update
        redirect_if_not_logged_in
        @log = Log.find(params[:id])
        @plant = Plant.find_by(id: @log.plant_id)        
        plant_not_current_users
        @log.update(log_params)
        if @log.save
            redirect_to plant_path(@log.plant)
        else 
            @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
            render :edit
      end
    end

    def destroy
        redirect_if_not_logged_in
        @log = Log.find_by(id: params[:id])
        if current_user.logs.include?(@log)
            @log.destroy
            redirect_to plant_path(@log.plant)
        else
            redirect_to plant_path(@log.plant)
        end
    end

    def index
        redirect_if_not_logged_in
       if params[:plant_id]
            @plant = Plant.find_by(id: params[:plant_id])
            @logs = @plant.logs
       else 
            @logs = Log.all
        end
    end
    
    private

    def log_params
        params.require(:log).permit(:water_date, :notes, :plant_id, :condition_update)
    end
end
