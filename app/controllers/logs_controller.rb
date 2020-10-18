class LogsController < ApplicationController
    def new
        @log = Log.new
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
        @log.plant_id = params[:plant_id]
    end

    def create
        @log = Log.new(log_params)
        if @log.save
        @plant = Plant.find_by(id: @log.plant_id)
        redirect_to plant_path(@plant)
        else
            render :new
        end
    end


    private
    def log_params
        params.require(:log).permit(:water_date, :notes, :plant_id, :condition_update)
    end
end
