module UsersHelper
    def logged_in?
        !!session[:user_id]
    end

    def current_user
        User.find_by(id: session[:user_id])
    end

    def redirect_if_not_logged_in
        if !logged_in?
            redirect_to '/'
        end
    end
    
    def plant_not_current_users
        if !current_user.plants.include?(@plant)
            redirect_to plant_path(@plant)
        end
    end

    def not_current_user
        if @user != current_user
            flash[:message]= "You aren't permitted to make that Edit"
            redirect_to user_path(@user)
        end
    end

    def not_the_commenter
        if @comment.commenter_id != current_user.id
            flash[:message]= "You aren't permitted to Edit this Comment"
            redirect_to plant_path(@comment.plant)
        end
    end

end
