class LogsController < ApplicationController
    def new
        @log = Log.new
        @conditions = ["It Died :(", "Significant Decline", "Slightly Worse", "No Change", "Slight Improvement", "Much Healthier", "Best Yet! 8^)"]
    end

    def create
        @log = Log.create
        byebug
    end
end
