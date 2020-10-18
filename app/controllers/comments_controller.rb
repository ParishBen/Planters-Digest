class CommentsController < ApplicationController
    def index 
        
        @plant = Plant.find_by_id(params[:plant_id])
        if @plant && @plant.comments.present?
            @comments = @plant.comments
        else
            @comments = Comment.all
        end
    end
    def create
        @plant = Plant.find_by_id(params[:plant_id])
        @comment = Comment.new.require(:comment).permit(:content)
        if @comment.save
            @comment.commenter_id = current_user.id
            redirect_to @plant
        else
            render :new
        end
        
    end
    def new
        @comment = Comment.new
        @comment.commenter_id = current_user.id
    end
end
