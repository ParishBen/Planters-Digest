class ApplicationController < ActionController::Base
    def you_logged_in?
        !!session[:user_id]
    end
end
