class CommentsController < ApplicationController
   include UsersHelper
    def index 
        @plant = Plant.find_by_id(params[:plant_id])
        if @plant && @plant.comments.present?
            @comments = @plant.comments
            @comment = Comment.new
        else
            @comments = Comment.all
        end
    end

    def new
        @comment = Comment.new
        @plant = Plant.find_by(id: params[:plant_id])
        @comment.commenter_id = current_user.id
        @comment.plant_id = @plant.id

    end

    def create
        @comment = Comment.new(comment_params)
        @plant = Plant.find_by(id: @comment.plant_id)
        #@comment.plant_id = @plant.id
        @comment.commenter_id = current_user.id
        if @comment.save
            #raise @comment.inspect
            redirect_to plant_path(@plant)
        else
            flash[:notice]= "Whelp that comment didn't go through"
            render :new
        end
       # raise params.inspect
    end

    def edit
        @comment = Comment.find(params[:id])
        if @comment.commenter.id != current_user.id
            redirect_to plant_path(@comment.plant)
        else 
            render :edit
        end
    end

    def update
        @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        if @comment.save
            redirect_to plant_path(@comment.plant)
        else 
            render :edit
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @plant = Plant.find_by(id: @comment.plant_id)
        @comment.destroy
        redirect_to plant_path(@plant)
    end
private

def comment_params
    params.require(:comment).permit(:plant_id, :commenter_id, :content) || params.require(:comments).permit(:plant_id, :commenter_id, :content)
end


end
